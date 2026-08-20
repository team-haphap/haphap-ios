import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Android `RegisterFifthSection.kt` (5단계: 완료)에 대응.
class RegisterFifthSection extends StatelessWidget {
  const RegisterFifthSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 36, 20, 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '등록이 완료되었어요!',
            style: AppTextStyles.subtitleBold22.copyWith(
              color: AppColors.gray800,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '소중한 결과를 등록해 주셔서 감사해요',
            style: AppTextStyles.bodyMedium14.copyWith(
              color: AppColors.gray500,
            ),
          ),
          const Expanded(flex: 136, child: SizedBox()),
          Center(
            child: Image.asset(
              'assets/images/register/img_register_check.png',
              width: 210,
              height: 210,
            ),
          ),
          const Expanded(flex: 210, child: SizedBox()),
        ],
      ),
    );
  }
}
