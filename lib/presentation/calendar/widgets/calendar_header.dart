import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/no_ripple_clickable.dart';
import '../../../core/type/year_month.dart';

/// Android `CalendarHeader.kt`에 대응.
class CalendarHeader extends StatelessWidget {
  const CalendarHeader({
    super.key,
    required this.yearMonth,
    required this.onDateClick,
    required this.onBackClick,
    required this.onNextClick,
  });

  final YearMonth yearMonth;
  final VoidCallback onDateClick;
  final VoidCallback onBackClick;
  final VoidCallback onNextClick;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NoRippleClickable(
            onTap: onBackClick,
            child: SvgPicture.asset(
              'assets/icons/calendar/icn_chevron_left_30.svg',
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(
                AppColors.gray400,
                BlendMode.srcIn,
              ),
            ),
          ),
          NoRippleClickable(
            onTap: onDateClick,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 42, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.gray100,
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '${yearMonth.year}년 ${yearMonth.month}월',
                style: AppTextStyles.bodySemiBold16.copyWith(
                  color: AppColors.gray700,
                ),
              ),
            ),
          ),
          NoRippleClickable(
            onTap: onNextClick,
            child: SvgPicture.asset(
              'assets/icons/calendar/icn_chevron_right_30.svg',
              width: 30,
              height: 30,
              colorFilter: const ColorFilter.mode(
                AppColors.gray400,
                BlendMode.srcIn,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
