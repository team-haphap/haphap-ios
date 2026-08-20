import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/extensions/date_time_ext.dart';
import '../../../core/type/present_chance_type.dart';
import '../../../core/type/year_month.dart';
import '../../../data/model/calendar/calendar_model.dart';
import 'calendar_day_cell.dart';

/// Android `CalendarGrid.kt`에 대응. 항상 6주(42칸)를 보여준다.
class CalendarGrid extends StatelessWidget {
  const CalendarGrid({
    super.key,
    required this.yearMonth,
    required this.selectedDate,
    required this.calendarModel,
    required this.onDaySelected,
  });

  final YearMonth yearMonth;
  final DateTime? selectedDate;
  final List<CalendarModel> calendarModel;
  final ValueChanged<DateTime> onDaySelected;

  @override
  Widget build(BuildContext context) {
    final firstDay = DateTime(yearMonth.year, yearMonth.month, 1);
    final dayIndex = firstDay.weekday % 7; // 일요일 시작 기준 offset
    final today = DateTime.now().toDateOnly();
    final selected = selectedDate?.toDateOnly();

    final likelihoodByDate = <DateTime, PresentChanceType>{
      for (final model in calendarModel) model.date.toDateOnly(): model.likelihood,
    };

    final days = [
      for (var offset = 0; offset < 42; offset++)
        firstDay.add(Duration(days: offset - dayIndex)),
    ];
    final weeks = [for (var i = 0; i < 6; i++) days.sublist(i * 7, i * 7 + 7)];

    final children = <Widget>[];
    for (final week in weeks) {
      children.add(
        const Divider(height: 1, thickness: 1, color: AppColors.gray100),
      );
      children.add(
        Row(
          children: [
            for (final day in week)
              Expanded(
                child: CalendarDayCell(
                  day: day,
                  isInMonth:
                      day.month == yearMonth.month && day.year == yearMonth.year,
                  isToday: day.isSameDate(today),
                  isSelected: selected != null && day.isSameDate(selected),
                  likelihood:
                      likelihoodByDate[day.toDateOnly()] ?? PresentChanceType.none,
                  onTap: () => onDaySelected(day),
                ),
              ),
          ],
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < children.length; i++) ...[
          if (i > 0) const SizedBox(height: 2),
          children[i],
        ],
      ],
    );
  }
}
