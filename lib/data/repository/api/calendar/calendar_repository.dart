import '../../../../core/util/result.dart';
import '../../../model/calendar/calendar_model.dart';
import '../../../model/calendar/calendar_posting_model.dart';

abstract class CalendarRepository {
  /// [date]는 "yyyy-MM" 형식([YearMonth.toDateString]).
  Future<Result<List<CalendarModel>>> getCalendar(String date);

  /// [date]는 "yyyy-MM-dd" 형식([DateTimeFormatExt.toDateString]).
  Future<Result<List<CalendarPostingModel>>> getCalendarPostings(String date);
}
