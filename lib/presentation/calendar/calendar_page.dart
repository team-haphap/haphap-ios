import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/type/year_month.dart';
import '../../core/widgets/bottomsheet/haphap_date_bottom_sheet.dart';
import 'calendar_riverpod.dart';
import 'widgets/calendar_bottom.dart';
import 'widgets/calendar_grid.dart';
import 'widgets/calendar_header.dart';
import 'widgets/calendar_posting_card.dart';
import 'widgets/calendar_posting_empty.dart';
import 'widgets/day_label_row.dart';

const _monthPagerStartPage = 100000;

/// 캘린더 (Android `CalendarScreen.kt` + `HapHapCustomCalendar.kt`에 대응).
class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  late final YearMonth _baseMonth;
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _baseMonth = YearMonth.now();
    _pageController = PageController(initialPage: _monthPagerStartPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  YearMonth _yearMonthForPage(int page) =>
      _baseMonth.plusMonths(page - _monthPagerStartPage);

  int _monthsBetween(YearMonth a, YearMonth b) =>
      (b.year - a.year) * 12 + (b.month - a.month);

  void _onPageChanged(int page) {
    ref.read(calendarProvider.notifier).changeMonth(_yearMonthForPage(page));
  }

  void _goToAdjacentMonth(int delta) {
    final current = _pageController.page!.round();
    _pageController.animateToPage(
      current + delta,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  Future<void> _openDatePicker(YearMonth yearMonth, DateTime? selectedDate) async {
    final picked = await showHapHapDateBottomSheet(
      context: context,
      initialDate:
          selectedDate ?? DateTime(yearMonth.year, yearMonth.month, 1),
    );
    if (picked == null) return;

    ref.read(calendarProvider.notifier).selectDate(picked);
    final targetPage = _monthPagerStartPage +
        _monthsBetween(_baseMonth, YearMonth.from(picked));
    _pageController.jumpToPage(targetPage);
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calendarProvider);
    final currentPage = _pageController.hasClients && _pageController.page != null
        ? _pageController.page!.round()
        : _monthPagerStartPage;
    final visibleMonth = state.visibleMonth ?? _yearMonthForPage(currentPage);

    final gridWidth = MediaQuery.of(context).size.width - 40;
    // 셀 하나 = AspectRatio(48/50) 콘텐츠 + 위쪽 padding 3(CalendarDayCell).
    final cellHeight = (gridWidth / 7) * 50 / 48 + 3;
    final gridHeight = 6 * cellHeight + 6 * 1 + 11 * 2;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            child: Column(
              children: [
                CalendarHeader(
                  yearMonth: visibleMonth,
                  onDateClick: () =>
                      _openDatePicker(visibleMonth, state.selectedDate),
                  onBackClick: () => _goToAdjacentMonth(-1),
                  onNextClick: () => _goToAdjacentMonth(1),
                ),
                const DayLabelRow(),
                SizedBox(
                  height: gridHeight,
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: _onPageChanged,
                    itemBuilder: (context, page) {
                      return CalendarGrid(
                        yearMonth: _yearMonthForPage(page),
                        selectedDate: state.selectedDate,
                        calendarModel: state.calendarModel,
                        onDaySelected: (date) =>
                            ref.read(calendarProvider.notifier).selectDate(date),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 2),
                const CalendarBottom(),
              ],
            ),
          ),
          Expanded(
            child: state.calendarPostings.isEmpty
                ? const CalendarPostingEmpty()
                : ColoredBox(
                    color: AppColors.gray100,
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 32,
                      ),
                      itemCount: state.calendarPostings.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) => CalendarPostingCard(
                        posting: state.calendarPostings[index],
                        // TODO: 공고 상세 화면 생기면 postingId로 이동.
                        onTap: () {},
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
