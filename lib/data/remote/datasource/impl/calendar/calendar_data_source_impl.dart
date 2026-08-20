import '../../../../remote/service/calendar_service.dart';
import '../../../dto/base_response.dart';
import '../../../dto/calendar/calendar_postings_response_dto.dart';
import '../../../dto/calendar/calendar_response_dto.dart';
import '../../api/calendar/calendar_data_source.dart';

class CalendarDataSourceImpl implements CalendarDataSource {
  const CalendarDataSourceImpl(this._calendarService);

  final CalendarService _calendarService;

  @override
  Future<BaseResponse<CalendarResponseDto>> getCalendar(String date) {
    return _calendarService.getCalendar(date);
  }

  @override
  Future<BaseResponse<CalendarPostingsResponseDto>> getCalendarPostings(
    String date,
  ) {
    return _calendarService.getCalendarPostings(date);
  }
}
