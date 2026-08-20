import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/type/present_chance_type.dart';

const _legendTypes = [
  PresentChanceType.veryLow,
  PresentChanceType.low,
  PresentChanceType.medium,
  PresentChanceType.high,
  PresentChanceType.veryHigh,
];

/// Android `CalendarBottom.kt`에 대응. "발표 가능성" 범례.
class CalendarBottom extends StatelessWidget {
  const CalendarBottom({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.gray400,
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              '발표 가능성',
              style: AppTextStyles.captionSemiBold12.copyWith(
                color: AppColors.gray100,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Text(
            '낮음',
            style: AppTextStyles.captionSemiBold12.copyWith(
              color: AppColors.gray400,
            ),
          ),
          for (final type in _legendTypes) ...[
            const SizedBox(width: 6),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: type.toColor(),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const SizedBox(height: 8),
              ),
            ),
          ],
          const SizedBox(width: 6),
          Text(
            '높음',
            style: AppTextStyles.captionSemiBold12.copyWith(
              color: AppColors.gray400,
            ),
          ),
        ],
      ),
    );
  }
}
