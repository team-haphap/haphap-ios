import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/network_riverpod.dart';
import '../../data/remote/datasource/api/calendar/calendar_data_source.dart';
import '../../data/remote/datasource/impl/calendar/calendar_data_source_impl.dart';
import '../../data/remote/service/calendar_service.dart';
import '../../data/repository/api/calendar/calendar_repository.dart';
import '../../data/repository/impl/calendar/calendar_repository_impl.dart';
import 'calendar_notifier.dart';

final _calendarServiceProvider = Provider(
  (ref) => CalendarService(ref.read(dioProvider)),
);

final _calendarDataSourceProvider = Provider<CalendarDataSource>(
  (ref) => CalendarDataSourceImpl(ref.read(_calendarServiceProvider)),
);

final calendarRepositoryProvider = Provider<CalendarRepository>(
  (ref) => CalendarRepositoryImpl(ref.read(_calendarDataSourceProvider)),
);

final calendarProvider = NotifierProvider<CalendarNotifier, CalendarState>(
  CalendarNotifier.new,
);
