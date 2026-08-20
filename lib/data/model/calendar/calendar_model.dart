import '../../../core/type/present_chance_type.dart';

/// Android `CalendarModel.kt`에 대응. 캘린더 월간 그리드의 날짜 하나.
class CalendarModel {
  const CalendarModel({
    required this.date,
    this.likelihood = PresentChanceType.none,
  });

  final DateTime date;
  final PresentChanceType likelihood;
}
