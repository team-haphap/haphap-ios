import 'package:dio/dio.dart';

import '../dto/base_response.dart';
import '../dto/calendar/calendar_postings_response_dto.dart';
import '../dto/calendar/calendar_response_dto.dart';

/// Android `CalendarService.kt`(Retrofit)에 대응하는 얇은 Dio 래퍼.
class CalendarService {
  const CalendarService(this._dio);

  final Dio _dio;

  /// `date`는 "yyyy-MM" 형식([YearMonth.toDateString]).
  Future<BaseResponse<CalendarResponseDto>> getCalendar(String date) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/calendar',
      queryParameters: {'date': date},
    );
    return BaseResponse.fromJson(response.data!, CalendarResponseDto.fromJson);
  }

  /// `date`는 "yyyy-MM-dd" 형식([DateTimeFormatExt.toDateString]).
  Future<BaseResponse<CalendarPostingsResponseDto>> getCalendarPostings(
    String date,
  ) async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/api/v1/calendar/postings',
      queryParameters: {'date': date},
    );
    return BaseResponse.fromJson(
      response.data!,
      CalendarPostingsResponseDto.fromJson,
    );
  }
}
