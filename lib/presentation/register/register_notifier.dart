import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/util/result.dart';
import '../../core/widgets/toast/haphap_toast_trigger.dart';
import '../../core/widgets/toast/haphap_toast_visuals.dart';
import '../../data/model/register/register_dropdown_item_model.dart';
import '../../data/model/register/register_model.dart';
import '../../data/model/register/register_process_model.dart';
import '../../data/model/register/registration_check_type.dart';
import '../../data/model/register/registration_model.dart';
import 'register_riverpod.dart';
import 'register_side_effect.dart';
import 'register_ui_state.dart';
import 'type/notification_channel_type.dart';
import 'type/pass_result_status_button.dart';

/// Android `RegisterContract.State`에 대응.
class RegisterState {
  const RegisterState({
    this.step = 1,
    this.registerInfo = const RegisterModel(),
    this.announceList = const [],
    this.selectedAnnounce,
    this.announceListUiState = const RegisterUiStateIdle(),
    this.processList = const [],
    this.processListUiState = const RegisterUiStateIdle(),
    this.selectedResult,
    this.isChangeModalVisible = false,
    this.registerUiState = const RegisterUiStateIdle(),
    this.registrationResult,
    this.isButtonEnabled = false,
    this.sideEffect,
  });

  final int step;
  final RegisterModel registerInfo;

  final List<RegisterDropDownItemModel> announceList;
  final RegisterDropDownItemModel? selectedAnnounce;
  final RegisterUiState announceListUiState;
  final List<RegisterProcessModel> processList;
  final RegisterUiState processListUiState;

  final PassResultStatusButton? selectedResult;
  final bool isChangeModalVisible;

  final RegisterUiState registerUiState;
  final RegistrationModel? registrationResult;

  final bool isButtonEnabled;

  /// 한 번 소비되면 지워지는 내비게이션 이벤트. [RegisterSideEffect] 참고.
  final RegisterSideEffect? sideEffect;

  RegisterState copyWith({
    int? step,
    RegisterModel? registerInfo,
    List<RegisterDropDownItemModel>? announceList,
    RegisterDropDownItemModel? selectedAnnounce,
    RegisterUiState? announceListUiState,
    List<RegisterProcessModel>? processList,
    RegisterUiState? processListUiState,
    PassResultStatusButton? selectedResult,
    bool clearSelectedResult = false,
    bool? isChangeModalVisible,
    RegisterUiState? registerUiState,
    RegistrationModel? registrationResult,
    bool? isButtonEnabled,
    RegisterSideEffect? sideEffect,
    bool clearSideEffect = false,
  }) {
    return RegisterState(
      step: step ?? this.step,
      registerInfo: registerInfo ?? this.registerInfo,
      announceList: announceList ?? this.announceList,
      selectedAnnounce: selectedAnnounce ?? this.selectedAnnounce,
      announceListUiState: announceListUiState ?? this.announceListUiState,
      processList: processList ?? this.processList,
      processListUiState: processListUiState ?? this.processListUiState,
      selectedResult: clearSelectedResult
          ? null
          : (selectedResult ?? this.selectedResult),
      isChangeModalVisible: isChangeModalVisible ?? this.isChangeModalVisible,
      registerUiState: registerUiState ?? this.registerUiState,
      registrationResult: registrationResult ?? this.registrationResult,
      isButtonEnabled: isButtonEnabled ?? this.isButtonEnabled,
      sideEffect: clearSideEffect ? null : (sideEffect ?? this.sideEffect),
    );
  }
}

/// Android `RegisterViewModel.kt`에 대응.
class RegisterNotifier extends Notifier<RegisterState> {
  /// Android는 `Register(jobId)` route 인자로 받아 목록 로딩 후 자동
  /// 선택한다. Flutter는 아직 공고 상세 화면이 없어 하단 탭에서 진입할
  /// 때는 항상 null — 공고 상세 화면이 생기면 family provider로 바꿔서
  /// 실제 jobId를 받도록 교체.
  static const int? _jobId = null;

  @override
  RegisterState build() {
    Future.microtask(_loadAnnounceList);
    return const RegisterState();
  }

  Future<void> _loadAnnounceList() async {
    state = state.copyWith(announceListUiState: const RegisterUiStateLoading());

    final result = await ref.read(registerRepositoryProvider).getRegisterPostNames();
    switch (result) {
      case Ok(:final value):
        state = state.copyWith(
          announceList: value,
          announceListUiState: const RegisterUiStateSuccess(),
        );
        RegisterDropDownItemModel? matched;
        for (final item in value) {
          if (item.id == _jobId) matched = item;
        }
        if (matched != null) onAnnounceSelected(matched);
      case Err(:final error):
        state = state.copyWith(
          announceListUiState: RegisterUiStateFailure(
            error.toString(),
          ),
        );
    }
  }

  void onAnnounceSelected(RegisterDropDownItemModel item) {
    state = state.copyWith(
      selectedAnnounce: item,
      registerInfo: state.registerInfo.copyWith(
        postingId: item.id,
        clearStageId: true,
      ),
      processList: const [],
      processListUiState: const RegisterUiStateLoading(),
      isButtonEnabled: false,
    );

    _loadStages(item.id);
  }

  Future<void> _loadStages(int postingId) async {
    final result = await ref
        .read(registerRepositoryProvider)
        .getRegisterPostStages(postingId);
    switch (result) {
      case Ok(:final value):
        state = state.copyWith(
          processList: value,
          processListUiState: const RegisterUiStateSuccess(),
        );
      case Err(:final error):
        state = state.copyWith(
          processListUiState: RegisterUiStateFailure(error.toString()),
        );
    }
  }

  void onProcessSelected(int id) {
    state = state.copyWith(
      registerInfo: state.registerInfo.copyWith(stageId: id),
      isButtonEnabled: state.selectedAnnounce != null,
    );
  }

  void onStep1NextClick() {
    if (!state.isButtonEnabled) return;
    state = state.copyWith(
      step: 2,
      isButtonEnabled: state.selectedResult != null,
    );
  }

  void onResultSelected(PassResultStatusButton result) {
    state = state.copyWith(selectedResult: result, isButtonEnabled: true);

    if (result == PassResultStatusButton.dontKnow) {
      state = state.copyWith(
        registerInfo: state.registerInfo.copyWith(
          clearContactedDate: true,
          clearContactedTime: true,
        ),
      );
    }
  }

  Future<void> onStep2NextClick() async {
    final selectedResult = state.selectedResult;
    final postingId = state.registerInfo.postingId;
    final stageId = state.registerInfo.stageId;
    if (selectedResult == null || postingId == null || stageId == null) {
      return;
    }
    final result = selectedResult.toRegisterResultType();

    final checkResult = await ref
        .read(registerRepositoryProvider)
        .postCheckRegistration(postingId, stageId, result);

    switch (checkResult) {
      case Ok(:final value):
        switch (value) {
          case RegistrationCheckType.newRegistration:
            _advanceFromStep2(selectedResult);
          case RegistrationCheckType.confirmRequired:
            state = state.copyWith(isChangeModalVisible: true);
          case RegistrationCheckType.duplicate:
            showHapHapToast(const HapHapToastVisuals(message: '이미 등록한 결과입니다'));
            state = state.copyWith(
              clearSelectedResult: true,
              isButtonEnabled: false,
            );
        }
      case Err():
        break;
    }
  }

  void onChangeModalConfirmClick() {
    final result = state.selectedResult;
    if (result == null) return;
    state = state.copyWith(isChangeModalVisible: false);
    _advanceFromStep2(result);
  }

  void onChangeModalCancelClick() {
    state = state.copyWith(isChangeModalVisible: false);
  }

  void _advanceFromStep2(PassResultStatusButton result) {
    final nextStep = result == PassResultStatusButton.dontKnow ? 4 : 3;
    state = state.copyWith(
      step: nextStep,
      isButtonEnabled: nextStep == 3
          ? _isContactDateTimeValid(
                  state.registerInfo.contactedDate,
                  state.registerInfo.contactedTime,
                ) &&
                state.registerInfo.contactedMethod.isNotEmpty
          : state.registerInfo.anonymous,
    );
  }

  void onDateSelected(DateTime date) {
    final dateString =
        '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    final updatedInfo = state.registerInfo.copyWith(contactedDate: dateString);
    final isValid = _isContactDateTimeValid(
      updatedInfo.contactedDate,
      updatedInfo.contactedTime,
    );

    state = state.copyWith(
      registerInfo: updatedInfo,
      isButtonEnabled: isValid && updatedInfo.contactedMethod.isNotEmpty,
    );

    if (updatedInfo.contactedTime != null && !isValid) {
      showHapHapToast(
        const HapHapToastVisuals(
          message: '현재 시간 이후로는 선택할 수 없어요',
          isAlarm: false,
        ),
      );
    }
  }

  void onTimeSelected(int hour, int minute) {
    final timeString =
        '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
    final updatedInfo = state.registerInfo.copyWith(contactedTime: timeString);
    final isValid = _isContactDateTimeValid(
      updatedInfo.contactedDate,
      updatedInfo.contactedTime,
    );

    state = state.copyWith(
      registerInfo: updatedInfo,
      isButtonEnabled: isValid && updatedInfo.contactedMethod.isNotEmpty,
    );

    if (updatedInfo.contactedDate != null && !isValid) {
      showHapHapToast(
        const HapHapToastVisuals(
          message: '현재 시간 이후로는 선택할 수 없어요',
          isAlarm: false,
        ),
      );
    }
  }

  void onChannelToggled(NotificationChannelType channel) {
    final current = state.registerInfo.contactedMethod;
    final toggled = current.contains(channel)
        ? current.where((e) => e != channel).toList()
        : [...current, channel];

    final updatedInfo = state.registerInfo.copyWith(contactedMethod: toggled);
    state = state.copyWith(
      registerInfo: updatedInfo,
      isButtonEnabled:
          _isContactDateTimeValid(
            updatedInfo.contactedDate,
            updatedInfo.contactedTime,
          ) &&
          updatedInfo.contactedMethod.isNotEmpty,
    );
  }

  void onStep3NextClick() {
    if (!state.isButtonEnabled) return;
    state = state.copyWith(step: 4, isButtonEnabled: state.registerInfo.anonymous);
  }

  void onBackClick() {
    final previousStep =
        state.step == 4 && state.selectedResult == PassResultStatusButton.dontKnow
        ? 2
        : state.step - 1;

    final isButtonEnabled = switch (previousStep) {
      1 => state.selectedAnnounce != null && state.registerInfo.stageId != null,
      2 => state.selectedResult != null,
      3 =>
        _isContactDateTimeValid(
          state.registerInfo.contactedDate,
          state.registerInfo.contactedTime,
        ) &&
            state.registerInfo.contactedMethod.isNotEmpty,
      _ => state.registerInfo.anonymous,
    };

    state = state.copyWith(step: previousStep, isButtonEnabled: isButtonEnabled);
  }

  void onAlarmAgreeToggled(bool checked) {
    state = state.copyWith(
      registerInfo: state.registerInfo.copyWith(alarmEnabled: checked),
    );
  }

  void onTermAgreeToggled(bool checked) {
    state = state.copyWith(
      registerInfo: state.registerInfo.copyWith(anonymous: checked),
      isButtonEnabled: checked && state.registerUiState is! RegisterUiStateLoading,
    );
  }

  Future<void> onRegisterClick() async {
    if (!state.isButtonEnabled) return;
    final result = state.selectedResult?.toRegisterResultType();
    if (result == null) return;

    final registerInfo = state.registerInfo.copyWith(result: result);
    state = state.copyWith(
      registerUiState: const RegisterUiStateLoading(),
      isButtonEnabled: false,
    );

    final response = await ref
        .read(registerRepositoryProvider)
        .postRegister(registerInfo);

    switch (response) {
      case Ok(:final value):
        state = state.copyWith(
          registerInfo: registerInfo,
          registrationResult: value,
          registerUiState: const RegisterUiStateSuccess(),
          step: 5,
          isButtonEnabled: true,
        );
      case Err(:final error):
        state = state.copyWith(
          registerUiState: RegisterUiStateFailure(error.toString()),
          isButtonEnabled: true,
        );
    }
  }

  void onFinishClick() {
    if (state.selectedResult == PassResultStatusButton.pass) {
      final card = state.registrationResult?.card;
      if (card != null) {
        state = state.copyWith(sideEffect: NavigateToPassCard(card));
      }
      return;
    }

    final jobId = _jobId;
    if (jobId != null) {
      state = state.copyWith(sideEffect: NavigateToJobDetail(jobId));
      return;
    }

    state = state.copyWith(sideEffect: const NavigateToHome());
  }

  void consumeSideEffect() {
    state = state.copyWith(clearSideEffect: true);
  }

  bool _isContactDateTimeValid(String? dateString, String? timeString) {
    if (dateString == null || timeString == null) return false;
    final date = DateTime.tryParse(dateString);
    final timeParts = timeString.split(':');
    if (date == null || timeParts.length < 2) return false;
    final hour = int.tryParse(timeParts[0]);
    final minute = int.tryParse(timeParts[1]);
    if (hour == null || minute == null) return false;
    final combined = DateTime(date.year, date.month, date.day, hour, minute);
    return !combined.isAfter(DateTime.now());
  }
}
