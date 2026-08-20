import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/circular_progress_indicator/haphap_circular_progress_indicator.dart';
import '../signup_complete/signup_complete_page.dart';
import 'login_notifier.dart';
import 'login_riverpod.dart';
import 'widgets/kakao_login_button.dart';

/// 회원가입 및 로그인 화면 (Android `LoginScreen.kt`에 대응)
class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(loginProvider);

    ref.listen(loginProvider, (previous, next) {
      final wasSuccess = previous?.loginUiState is LoginUiStateSuccess;
      if (next.loginUiState is LoginUiStateSuccess && !wasSuccess) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => SignupCompletePage(userName: next.userName!),
          ),
        );
      }
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: switch (state.loginUiState) {
          LoginUiStateLoading() => const HapHapCircularProgressIndicator(),
          LoginUiStateSuccess() => const SizedBox.shrink(),
          LoginUiStateIdle() || LoginUiStateFailure() => _LoginContent(
            onKakaoLoginClick: () =>
                ref.read(loginProvider.notifier).loginWithKakao(),
          ),
        },
      ),
    );
  }
}

class _LoginContent extends StatelessWidget {
  const _LoginContent({required this.onKakaoLoginClick});

  final VoidCallback onKakaoLoginClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 13),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Spacer(),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset('assets/images/logo_img.png', width: 48, height: 50),
              const SizedBox(width: 16),
              Image.asset(
                'assets/images/typo_logo.png',
                width: 206,
                height: 34,
              ),
            ],
          ),
          const SizedBox(height: 20),
          Text(
            '합격 발표가 움직이는 순간',
            style: AppTextStyles.bodyMedium14.copyWith(
              color: AppColors.gray400,
            ),
          ),
          const Spacer(),
          Text(
            '회원 서비스 이용을 위해 로그인해주세요',
            style: AppTextStyles.captionRegular10.copyWith(
              color: AppColors.gray600,
            ),
          ),
          const SizedBox(height: 29),
          KakaoLoginButton(onPressed: onKakaoLoginClick),
        ],
      ),
    );
  }
}
