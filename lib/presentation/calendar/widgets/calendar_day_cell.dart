import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/no_ripple_clickable.dart';
import '../../../core/type/present_chance_type.dart';

/// Android `CalendarDayItem.kt`(+ `DayType.kt`)에 대응. 월간 그리드의 날짜 한 칸.
class CalendarDayCell extends StatelessWidget {
  const CalendarDayCell({
    super.key,
    required this.day,
    required this.isInMonth,
    required this.isToday,
    required this.isSelected,
    required this.likelihood,
    required this.onTap,
  });

  final DateTime day;
  final bool isInMonth;
  final bool isToday;
  final bool isSelected;
  final PresentChanceType likelihood;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = !isInMonth
        ? AppColors.gray200
        : (isSelected ? AppColors.primary100 : AppColors.gray700);
    final chanceColor = !isInMonth ? Colors.transparent : likelihood.toColor();

    return NoRippleClickable(
      onTap: isInMonth ? onTap : () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 3),
        child: AspectRatio(
          aspectRatio: 48 / 50,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '${day.day}',
                style: AppTextStyles.bodySemiBold13.copyWith(color: textColor),
              ),
              if (isInMonth && isToday) ...[
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  child: SvgPicture.asset(
                    'assets/icons/calendar/icn_calendar_today.svg',
                    width: 26,
                    height: 26 * 24 / 25,
                    colorFilter: ColorFilter.mode(chanceColor, BlendMode.srcIn),
                  ),
                ),
              ] else if (isInMonth && likelihood != PresentChanceType.none) ...[
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: chanceColor,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: const SizedBox(height: 6, width: double.infinity),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
