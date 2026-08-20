import 'package:flutter/material.dart';

import 'haphap_bottom_sheet.dart';
import 'haphap_picker.dart';

/// 년/월/일을 휠로 선택하는 날짜 선택 바텀시트.
///
/// 년/월/일 세 휠이 서로 연동되어, 월(또는 년)을 바꾸면 그 달의 실제
/// 일수에 맞춰 일(day) 휠의 선택 가능 범위가 자동으로 갱신된다.
///
/// "확인"을 누르면 선택된 [DateTime]을 반환하며 닫히고, 그 외 어떤
/// 방식으로 닫히든(취소 버튼, 바깥 탭, 뒤로가기) `null`을 반환한다.
class HapHapDateBottomSheet extends StatefulWidget {
  const HapHapDateBottomSheet({
    super.key,
    this.initialDate,
    this.minYear = 2000,
    this.maxYear = 2030,
  });

  final DateTime? initialDate;
  final int minYear;
  final int maxYear;

  @override
  State<HapHapDateBottomSheet> createState() => _HapHapDateBottomSheetState();
}

class _HapHapDateBottomSheetState extends State<HapHapDateBottomSheet> {
  late int _year;
  late int _month;
  late int _day;
  late final List<int> _years;
  final _dayController = HapHapPickerController();

  @override
  void initState() {
    super.initState();
    final initial = widget.initialDate ?? DateTime.now();
    _year = initial.year.clamp(widget.minYear, widget.maxYear);
    _month = initial.month;
    _day = initial.day;
    _years = [for (var y = widget.minYear; y <= widget.maxYear; y++) y];
  }

  @override
  void dispose() {
    _dayController.dispose();
    super.dispose();
  }

  int get _daysInMonth => DateUtils.getDaysInMonth(_year, _month);

  List<String> get _dayItems => [for (var d = 1; d <= _daysInMonth; d++) '$d일'];

  void _handleYearChanged(String value) {
    _year = int.parse(value.replaceAll('년', ''));
    _clampDay();
  }

  void _handleMonthChanged(String value) {
    _month = int.parse(value.replaceAll('월', ''));
    _clampDay();
  }

  void _handleDayChanged(String value) {
    _day = int.parse(value.replaceAll('일', ''));
  }

  void _clampDay() {
    final maxDay = _daysInMonth;
    setState(() {
      if (_day > maxDay) {
        _day = maxDay;
        _dayController.scrollToItem(maxDay - 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return HapHapBottomSheet(
      onCancel: () => Navigator.of(context).pop(),
      onConfirm: () => Navigator.of(context).pop(DateTime(_year, _month, _day)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HapHapPicker(
            items: [for (final y in _years) '$y년'],
            startIndex: _years.indexOf(_year),
            onSelectedItemChanged: _handleYearChanged,
          ),
          const SizedBox(width: 24),
          HapHapPicker(
            items: [for (var m = 1; m <= 12; m++) '$m월'],
            startIndex: _month - 1,
            onSelectedItemChanged: _handleMonthChanged,
          ),
          const SizedBox(width: 24),
          HapHapPicker(
            items: _dayItems,
            controller: _dayController,
            startIndex: _day - 1,
            onSelectedItemChanged: _handleDayChanged,
          ),
        ],
      ),
    );
  }
}

/// [HapHapDateBottomSheet]를 모달로 띄운다. 확인 시 선택된 날짜, 취소/바깥
/// 탭/뒤로가기로 닫히면 `null`을 반환한다.
Future<DateTime?> showHapHapDateBottomSheet({
  required BuildContext context,
  DateTime? initialDate,
  int minYear = 2000,
  int maxYear = 2030,
}) {
  return showHapHapBottomSheet<DateTime>(
    context: context,
    builder: (context) => HapHapDateBottomSheet(
      initialDate: initialDate,
      minYear: minYear,
      maxYear: maxYear,
    ),
  );
}
