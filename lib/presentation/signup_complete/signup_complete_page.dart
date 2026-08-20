import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/extensions/navigator_ext.dart';
import '../../core/type/button_type.dart';
import '../../core/widgets/button/haphap_basic_button.dart';
import '../navigation/navigation_page.dart';

/// 로그인 완료 화면 (Android `SignUpCompleteScreen.kt`에 대응)
class SignupCompletePage extends StatelessWidget {
  const SignupCompletePage({super.key, required this.userName});

  final String userName;

  @override
  Widget build(BuildContext context) {
    final displayName = userName.isEmpty ? '사용자' : userName;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 43, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '$displayName님 가입을 완료했어요!',
                style: AppTextStyles.subtitleBold22.copyWith(
                  color: AppColors.gray800,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '지원자들의 결과를 확인하고 내 상태도 등록해보세요',
                style: AppTextStyles.bodyMedium14.copyWith(
                  color: AppColors.gray500,
                ),
              ),
              const Spacer(flex: 188),
              Center(
                child: Image.asset(
                  'assets/images/logo_img.png',
                  width: 64,
                  height: 68,
                ),
              ),
              const SizedBox(height: 16),
              Center(
                child: Image.asset(
                  'assets/images/typo_logo.png',
                  width: 191,
                  height: 29,
                ),
              ),
              const Spacer(flex: 265),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: HapHapBasicButton(
                  text: '시작하기',
                  textStyle: AppTextStyles.bodyBold18,
                  colorType: const HapHapButtonTypePrimary(),
                  onClick: () => Navigator.of(
                    context,
                  ).pushAndClearBackStack(const NavigationPage()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
