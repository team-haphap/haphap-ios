import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

/// 휠 한 줄의 높이. [HapHapBottomSheet]가 가운데 강조 배경 높이를 맞출 때도 쓴다.
const double kPickerItemExtent = 44;

/// [HapHapPicker]를 외부에서 프로그래밍적으로 스크롤시키기 위한 핸들.
///
/// Android판 `PickerState`와 달리 선택값은 `onSelectedItemChanged` 콜백으로
/// 직접 받으므로, 이 컨트롤러는 오직 `scrollToItem`(외부 요인으로 선택 가능
/// 범위가 바뀌었을 때 위치를 강제로 맞추는 용도)만 담당한다.
class HapHapPickerController {
  _HapHapPickerState? _state;

  void _attach(_HapHapPickerState state) => _state = state;

  void _detach(_HapHapPickerState state) {
    if (_state == state) _state = null;
  }

  void scrollToItem(int index) => _state?._scrollToItem(index);

  void dispose() => _state = null;
}

/// 세로로 스크롤되는 휠(wheel) 형태의 아이템 선택 컴포넌트.
///
/// 정중앙에 위치한 아이템이 선택된 값으로 취급되며, 스크롤을 멈추면 항상
/// 하나의 아이템이 정중앙에 오도록 스냅된다. 선택된 값은 문자열로
/// [onSelectedItemChanged]를 통해 전달된다.
class HapHapPicker extends StatefulWidget {
  const HapHapPicker({
    super.key,
    required this.items,
    this.controller,
    this.isInfinite = false,
    this.startIndex = 0,
    this.visibleItemsCount = 5,
    this.itemExtent = kPickerItemExtent,
    this.onSelectedItemChanged,
  });

  /// 휠에 표시할 아이템 목록. 비어있으면 아무것도 렌더링하지 않는다.
  final List<String> items;

  /// [scrollToItem]으로 외부에서 위치를 강제할 때만 필요.
  final HapHapPickerController? controller;

  /// true면 리스트 끝에서 처음으로 순환하는 무한 스크롤.
  final bool isInfinite;

  /// 최초 선택 상태로 보여줄 [items]의 인덱스.
  final int startIndex;

  /// 화면에 동시에 보이는 아이템 개수(홀수 권장).
  final int visibleItemsCount;

  /// 아이템 한 줄의 높이.
  final double itemExtent;

  /// 선택된 아이템이 바뀔 때마다 그 문자열 값을 전달한다.
  final ValueChanged<String>? onSelectedItemChanged;

  @override
  State<HapHapPicker> createState() => _HapHapPickerState();
}

class _HapHapPickerState extends State<HapHapPicker> {
  late final FixedExtentScrollController _scrollController;
  late int _centerIndex;

  @override
  void initState() {
    super.initState();
    _centerIndex = widget.startIndex;
    _scrollController = FixedExtentScrollController(
      initialItem: widget.startIndex,
    );
    widget.controller?._attach(this);
  }

  @override
  void didUpdateWidget(covariant HapHapPicker oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.controller != widget.controller) {
      oldWidget.controller?._detach(this);
      widget.controller?._attach(this);
    }
    if (_centerIndex >= widget.items.length && widget.items.isNotEmpty) {
      _centerIndex = widget.items.length - 1;
    }
  }

  @override
  void dispose() {
    widget.controller?._detach(this);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToItem(int index) {
    if (!_scrollController.hasClients) return;
    _scrollController.jumpToItem(index);
  }

  int _wrapIndex(int rawIndex) {
    if (!widget.isInfinite) return rawIndex;
    final length = widget.items.length;
    return ((rawIndex % length) + length) % length;
  }

  void _handleSelectedItemChanged(int rawIndex) {
    final index = _wrapIndex(rawIndex);
    setState(() => _centerIndex = index);
    widget.onSelectedItemChanged?.call(widget.items[index]);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.items.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      height: widget.itemExtent * widget.visibleItemsCount,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: widget.itemExtent,
        perspective: 0.003,
        diameterRatio: 1.8,
        physics: const FixedExtentScrollPhysics(),
        onSelectedItemChanged: _handleSelectedItemChanged,
        childDelegate: widget.isInfinite
            ? ListWheelChildLoopingListDelegate(children: _buildItems())
            : ListWheelChildListDelegate(children: _buildItems()),
      ),
    );
  }

  List<Widget> _buildItems() {
    return [for (var i = 0; i < widget.items.length; i++) _buildItem(i)];
  }

  Widget _buildItem(int index) {
    final distance = (index - _centerIndex).abs();
    final color = switch (distance) {
      0 => AppColors.gray700,
      1 => AppColors.gray400,
      _ => AppColors.gray200,
    };
    return Center(
      child: Text(
        widget.items[index],
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles.bodySemiBold18.copyWith(color: color),
      ),
    );
  }
}
