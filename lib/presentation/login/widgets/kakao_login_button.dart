import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/no_ripple_clickable.dart';

class KakaoLoginButton extends StatelessWidget {
  const KakaoLoginButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return NoRippleClickable(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.yellow,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/kakao_icon.svg',
              width: 20,
              height: 20,
              colorFilter: const ColorFilter.mode(
                AppColors.gray800,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(width: 12),
            Text(
              '카카오로 시작하기',
              style: AppTextStyles.captionSemiBold12.copyWith(
                color: AppColors.gray800,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
