import '../../../../core/util/result.dart';
import '../../../../core/util/run_catching.dart';
import '../../../mapper/calendar/calendar_mapper.dart';
import '../../../model/calendar/calendar_model.dart';
import '../../../model/calendar/calendar_posting_model.dart';
import '../../../remote/datasource/api/calendar/calendar_data_source.dart';
import '../../api/calendar/calendar_repository.dart';

class CalendarRepositoryImpl implements CalendarRepository {
  const CalendarRepositoryImpl(this._dataSource);

  final CalendarDataSource _dataSource;

  @override
  Future<Result<List<CalendarModel>>> getCalendar(String date) {
    return runCatchingAsync(() async {
      final response = await _dataSource.getCalendar(date);
      final dto = response.checkData();
      return dto.dates.map((e) => e.toModel()).toList();
    });
  }

  @override
  Future<Result<List<CalendarPostingModel>>> getCalendarPostings(
    String date,
  ) {
    return runCatchingAsync(() async {
      final response = await _dataSource.getCalendarPostings(date);
      final dto = response.checkData();
      return dto.postings.map((e) => e.toModel()).toList();
    });
  }
}
