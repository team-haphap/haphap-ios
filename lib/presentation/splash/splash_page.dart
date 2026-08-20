import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/extensions/navigator_ext.dart';
import '../login/login_page.dart';
import '../navigation/navigation_page.dart';
import 'splash_riverpod.dart';

/// 스플래시 화면 (Android `SplashScreen.kt`에 대응)
class SplashPage extends ConsumerWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(splashProvider, (previous, next) {
      if (next.isLoggedIn == null) return;
      final target = next.isLoggedIn!
          ? const NavigationPage()
          : const LoginPage();
      Navigator.of(context).pushAndClearBackStack(target);
    });

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/logo_img.png',
                width: 120,
                height: 121,
              ),
              const Spacer(),
              Image.asset(
                'assets/images/typo_logo.png',
                width: 144,
                height: 22,
              ),
              const SizedBox(height: 12),
              Text(
                '합격 발표가 움직이는 순간',
                style: AppTextStyles.bodyRegular14.copyWith(
                  color: AppColors.gray400,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
