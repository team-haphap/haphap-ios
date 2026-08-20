import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// 일요일 시작. Android `defaultDaysOfWeek`에 대응.
const kDayLabels = ['일', '월', '화', '수', '목', '금', '토'];

/// Android `DayLabelRow.kt`에 대응.
class DayLabelRow extends StatelessWidget {
  const DayLabelRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6),
      child: Row(
        children: [
          for (final label in kDayLabels)
            Expanded(
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTextStyles.bodySemiBold13.copyWith(
                  color: AppColors.gray600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
