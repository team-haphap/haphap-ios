import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/extensions/date_time_ext.dart';
import '../../core/state/ui_state.dart';
import '../../core/type/year_month.dart';
import '../../core/util/result.dart';
import '../../data/model/calendar/calendar_model.dart';
import '../../data/model/calendar/calendar_posting_model.dart';
import 'calendar_riverpod.dart';

/// Android `CalendarContract.State`에 대응.
class CalendarState {
  const CalendarState({
    this.visibleMonth,
    this.selectedDate,
    this.calendarModel = const [],
    this.calendarPostings = const [],
    this.calendarUiState = const UiStateIdle(),
    this.calendarPostingsUiState = const UiStateIdle(),
  });

  final YearMonth? visibleMonth;
  final DateTime? selectedDate;
  final List<CalendarModel> calendarModel;
  final List<CalendarPostingModel> calendarPostings;
  final UiState<List<CalendarModel>> calendarUiState;
  final UiState<List<CalendarPostingModel>> calendarPostingsUiState;

  CalendarState copyWith({
    YearMonth? visibleMonth,
    DateTime? selectedDate,
    List<CalendarModel>? calendarModel,
    List<CalendarPostingModel>? calendarPostings,
    UiState<List<CalendarModel>>? calendarUiState,
    UiState<List<CalendarPostingModel>>? calendarPostingsUiState,
  }) {
    return CalendarState(
      visibleMonth: visibleMonth ?? this.visibleMonth,
      selectedDate: selectedDate ?? this.selectedDate,
      calendarModel: calendarModel ?? this.calendarModel,
      calendarPostings: calendarPostings ?? this.calendarPostings,
      calendarUiState: calendarUiState ?? this.calendarUiState,
      calendarPostingsUiState:
          calendarPostingsUiState ?? this.calendarPostingsUiState,
    );
  }
}

/// Android `CalendarViewModel.kt`에 대응.
class CalendarNotifier extends Notifier<CalendarState> {
  @override
  CalendarState build() {
    final today = DateTime.now().toDateOnly();
    Future.microtask(() {
      changeMonth(YearMonth.from(today));
      selectDate(today);
    });
    return CalendarState(visibleMonth: YearMonth.from(today), selectedDate: today);
  }

  Future<void> changeMonth(YearMonth yearMonth) async {
    state = state.copyWith(
      visibleMonth: yearMonth,
      calendarUiState: const UiStateLoading(),
    );

    final result = await ref
        .read(calendarRepositoryProvider)
        .getCalendar(yearMonth.toDateString());

    switch (result) {
      case Ok(:final value):
        state = state.copyWith(
          calendarModel: value,
          calendarUiState: UiStateSuccess(value),
        );
      case Err(:final error):
        state = state.copyWith(
          calendarUiState: UiStateFailure(error.toString()),
        );
    }
  }

  Future<void> selectDate(DateTime date) async {
    final selected = date.toDateOnly();
    state = state.copyWith(
      selectedDate: selected,
      calendarPostingsUiState: const UiStateLoading(),
    );

    final result = await ref
        .read(calendarRepositoryProvider)
        .getCalendarPostings(selected.toDateString());

    switch (result) {
      case Ok(:final value):
        state = state.copyWith(
          calendarPostings: value,
          calendarPostingsUiState: UiStateSuccess(value),
        );
      case Err(:final error):
        state = state.copyWith(
          calendarPostingsUiState: UiStateFailure(error.toString()),
        );
    }
  }
}
