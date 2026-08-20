import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/type/button_type.dart';
import '../../core/widgets/button/haphap_basic_button.dart';
import '../../core/widgets/haphap_nav_bar.dart' show AppNavTab;
import '../../core/widgets/modal/haphap_dialog.dart';
import '../navigation/navigation_riverpod.dart';
import 'passcard/register_pass_card_page.dart';
import 'register_notifier.dart';
import 'register_riverpod.dart';
import 'register_side_effect.dart';
import 'sections/register_fifth_section.dart';
import 'sections/register_first_section.dart';
import 'sections/register_fourth_section.dart';
import 'sections/register_second_section.dart';
import 'sections/register_third_section.dart';
import 'widgets/register_progress_bar.dart';
import 'widgets/register_top_bar.dart';

/// Android `RegisterScreen.kt`에 대응.
class RegisterPage extends ConsumerWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(registerProvider);
    final notifier = ref.read(registerProvider.notifier);

    ref.listen(registerProvider, (previous, next) {
      final effect = next.sideEffect;
      if (effect != null && effect != previous?.sideEffect) {
        notifier.consumeSideEffect();
        _handleSideEffect(context, ref, effect);
      }

      if (next.isChangeModalVisible &&
          previous?.isChangeModalVisible != true) {
        showHapHapDialog(
          context: context,
          content: '이전에 등록한 결과가 있습니다.\n선택한 결과로 변경할까요?',
          onConfirmClick: () {
            Navigator.of(context).pop();
            notifier.onChangeModalConfirmClick();
          },
        ).then((_) {
          if (ref.read(registerProvider).isChangeModalVisible) {
            notifier.onChangeModalCancelClick();
          }
        });
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      bottomNavigationBar: SafeArea(
        top: false,
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: HapHapBasicButton(
              text: switch (state.step) {
                1 || 2 || 3 => '다음',
                4 => '등록하기',
                _ => '완료',
              },
              textStyle: AppTextStyles.bodyBold18,
              colorType: HapHapButtonTypePrimary(enabled: state.isButtonEnabled),
              onClick: () => _onNextClick(notifier, state.step),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          if (state.step < 5) ...[
            RegisterTopBar(
              onBackClick: () => _onTopBarBackClick(ref, state.step),
            ),
            if (state.step <= 3)
              RegisterProgressBar(progress: state.step, totalSteps: 3)
            else if (state.step == 4)
              const SizedBox(height: 48),
          ],
          Expanded(child: _buildStep(state, notifier)),
        ],
      ),
    );
  }

  Widget _buildStep(RegisterState state, RegisterNotifier notifier) {
    return switch (state.step) {
      1 => RegisterFirstSection(
        announceList: state.announceList,
        selectedAnnounce: state.selectedAnnounce,
        onAnnounceSelected: notifier.onAnnounceSelected,
        processList: state.processList,
        processListUiState: state.processListUiState,
        selectedProcessId: state.registerInfo.stageId,
        onProcessSelected: notifier.onProcessSelected,
      ),
      2 => RegisterSecondSection(
        selectedResult: state.selectedResult,
        onResultSelected: notifier.onResultSelected,
      ),
      3 => RegisterThirdSection(
        contactDate: state.registerInfo.contactedDate,
        onDateSelected: notifier.onDateSelected,
        contactTime: state.registerInfo.contactedTime,
        onTimeSelected: notifier.onTimeSelected,
        selectedChannels: state.registerInfo.contactedMethod,
        onChannelToggled: notifier.onChannelToggled,
      ),
      4 => RegisterFourthSection(
        recruitName: state.selectedAnnounce?.text ?? '',
        recruitProcess: _selectedProcessText(state),
        selectedResult: state.selectedResult,
        contactDate: state.registerInfo.contactedDate,
        contactTime: state.registerInfo.contactedTime,
        isAlarmAgreed: state.registerInfo.alarmEnabled,
        onAlarmAgreeToggled: notifier.onAlarmAgreeToggled,
        isTermAgreed: state.registerInfo.anonymous,
        onTermAgreeToggled: notifier.onTermAgreeToggled,
      ),
      _ => const RegisterFifthSection(),
    };
  }

  String _selectedProcessText(RegisterState state) {
    for (final process in state.processList) {
      if (process.id == state.registerInfo.stageId) return process.text;
    }
    return '';
  }

  void _onTopBarBackClick(WidgetRef ref, int step) {
    final notifier = ref.read(registerProvider.notifier);
    if (step == 1) {
      ref.read(navigationProvider.notifier).setTab(AppNavTab.home);
    } else {
      notifier.onBackClick();
    }
  }

  void _onNextClick(RegisterNotifier notifier, int step) {
    switch (step) {
      case 1:
        notifier.onStep1NextClick();
      case 2:
        notifier.onStep2NextClick();
      case 3:
        notifier.onStep3NextClick();
      case 4:
        notifier.onRegisterClick();
      default:
        notifier.onFinishClick();
    }
  }

  void _handleSideEffect(
    BuildContext context,
    WidgetRef ref,
    RegisterSideEffect effect,
  ) {
    switch (effect) {
      case NavigateToHome():
        ref.read(navigationProvider.notifier).setTab(AppNavTab.home);
      case NavigateToJobDetail():
        // TODO: 공고 상세 화면이 생기면 해당 화면으로 이동.
        ref.read(navigationProvider.notifier).setTab(AppNavTab.home);
      case NavigateToPassCard(:final passCard):
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => RegisterPassCardPage(passCard: passCard),
          ),
        );
    }
  }
}
