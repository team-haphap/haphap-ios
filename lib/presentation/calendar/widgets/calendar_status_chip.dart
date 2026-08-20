import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Android `CalendarStatusChip.kt`에 대응.
class CalendarStatusChip extends StatelessWidget {
  const CalendarStatusChip({
    super.key,
    required this.chipText,
    required this.isExpectedStage,
  });

  final String chipText;
  final bool isExpectedStage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6),
      decoration: BoxDecoration(
        color: isExpectedStage ? AppColors.sub100 : AppColors.gray100,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        chipText,
        style: AppTextStyles.captionSemiBold12.copyWith(
          color: isExpectedStage ? AppColors.primary100 : AppColors.gray500,
        ),
      ),
    );
  }
}
