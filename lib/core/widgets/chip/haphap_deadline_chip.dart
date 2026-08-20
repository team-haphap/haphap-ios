import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

/// 마감(디데이) 상태칩 — "{전형명} 발표" + dDay 형태로 표시된다.
/// 전형명 부분은 gray600, 디데이 부분은 primary500.
class HapHapDeadlineChip extends StatelessWidget {
  const HapHapDeadlineChip({
    super.key,
    required this.stage,
    required this.dDay,
  });

  final String stage;
  final String dDay;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            stage.isEmpty ? '발표' : '$stage 발표',
            style: AppTextStyles.captionMedium10.copyWith(
              color: AppColors.gray600,
            ),
          ),
          const SizedBox(width: 2),
          Text(
            dDay,
            style: AppTextStyles.captionMedium10.copyWith(
              color: AppColors.primary500,
            ),
          ),
        ],
      ),
    );
  }
}
