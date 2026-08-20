import '../../../dto/base_response.dart';
import '../../../dto/calendar/calendar_postings_response_dto.dart';
import '../../../dto/calendar/calendar_response_dto.dart';

abstract class CalendarDataSource {
  Future<BaseResponse<CalendarResponseDto>> getCalendar(String date);

  Future<BaseResponse<CalendarPostingsResponseDto>> getCalendarPostings(
    String date,
  );
}
