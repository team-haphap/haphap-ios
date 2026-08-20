import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Android `RegisterResultConfirm.kt`에 대응.
class RegisterResultConfirm extends StatelessWidget {
  const RegisterResultConfirm({
    super.key,
    required this.recruitName,
    required this.recruitProcess,
  });

  final String recruitName;
  final String recruitProcess;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '지원 정보',
                  style: AppTextStyles.captionMedium12.copyWith(
                    color: AppColors.gray400,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  recruitName,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles.bodySemiBold14.copyWith(
                    color: AppColors.gray600,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              recruitProcess,
              style: AppTextStyles.captionSemiBold12.copyWith(
                color: AppColors.gray500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
