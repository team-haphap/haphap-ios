import 'package:flutter/material.dart';

import 'haphap_bottom_sheet.dart';
import 'haphap_picker.dart';

/// 시/분을 휠로 선택하는 시간 선택 바텀시트.
///
/// 시(00~23)/분(00~59) 휠은 끝까지 스크롤하면 처음으로 순환되는 무한
/// 스크롤로 동작한다.
///
/// "확인"을 누르면 선택된 시:분을 담은 [TimeOfDay]를 반환하며 닫히고,
/// 그 외 어떤 방식으로 닫히든(취소 버튼, 바깥 탭, 뒤로가기) `null`을
/// 반환한다.
class HapHapTimeBottomSheet extends StatefulWidget {
  const HapHapTimeBottomSheet({super.key, this.initialTime});

  final TimeOfDay? initialTime;

  @override
  State<HapHapTimeBottomSheet> createState() => _HapHapTimeBottomSheetState();
}

class _HapHapTimeBottomSheetState extends State<HapHapTimeBottomSheet> {
  late int _hour;
  late int _minute;

  static final _hours = [for (var h = 0; h < 24; h++) h];
  static final _minutes = [for (var m = 0; m < 60; m++) m];

  @override
  void initState() {
    super.initState();
    final initial = widget.initialTime ?? TimeOfDay.now();
    _hour = initial.hour;
    _minute = initial.minute;
  }

  void _handleHourChanged(String value) {
    _hour = int.parse(value.replaceAll('시', ''));
  }

  void _handleMinuteChanged(String value) {
    _minute = int.parse(value.replaceAll('분', ''));
  }

  @override
  Widget build(BuildContext context) {
    return HapHapBottomSheet(
      onCancel: () => Navigator.of(context).pop(),
      onConfirm: () =>
          Navigator.of(context).pop(TimeOfDay(hour: _hour, minute: _minute)),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          HapHapPicker(
            items: [for (final h in _hours) '${h.toString().padLeft(2, '0')}시'],
            startIndex: _hour,
            isInfinite: true,
            onSelectedItemChanged: _handleHourChanged,
          ),
          const SizedBox(width: 24),
          HapHapPicker(
            items: [
              for (final m in _minutes) '${m.toString().padLeft(2, '0')}분',
            ],
            startIndex: _minute,
            isInfinite: true,
            onSelectedItemChanged: _handleMinuteChanged,
          ),
        ],
      ),
    );
  }
}

/// [HapHapTimeBottomSheet]를 모달로 띄운다. 확인 시 선택된 시간, 취소/바깥
/// 탭/뒤로가기로 닫히면 `null`을 반환한다.
Future<TimeOfDay?> showHapHapTimeBottomSheet({
  required BuildContext context,
  TimeOfDay? initialTime,
}) {
  return showHapHapBottomSheet<TimeOfDay>(
    context: context,
    builder: (context) => HapHapTimeBottomSheet(initialTime: initialTime),
  );
}
