import 'package:flutter/material.dart';

/// 텍스트 입력을 위한 기본 텍스트 필드 컴포넌트. 장식이 없는 순수 입력
/// 영역을 제공하며, 다른 TextField UI 컴포넌트에서 입력 영역으로 함께
/// 쓰인다(예: [HapHapSearchTextField]).
class HapHapBasicTextField extends StatelessWidget {
  const HapHapBasicTextField({
    super.key,
    required this.controller,
    required this.textColor,
    required this.textStyle,
    required this.placeholder,
    required this.placeholderColor,
    required this.placeholderStyle,
    this.enabled = true,
    this.readOnly = false,
    this.keyboardType,
    this.textInputAction,
    this.onSubmitted,
    this.maxLines = 1,
    this.cursorColor,
    this.suffix,
    this.focusNode,
  });

  final TextEditingController controller;
  final Color textColor;
  final TextStyle textStyle;
  final String placeholder;
  final Color placeholderColor;
  final TextStyle placeholderStyle;
  final bool enabled;
  final bool readOnly;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onSubmitted;
  final int? maxLines;
  final Color? cursorColor;

  /// 텍스트 필드 우측 끝에 배치될 추가 요소(아이콘, 버튼 등).
  final Widget? suffix;
  final FocusNode? focusNode;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            focusNode: focusNode,
            enabled: enabled,
            readOnly: readOnly,
            keyboardType: keyboardType,
            textInputAction: textInputAction,
            onSubmitted: onSubmitted,
            maxLines: maxLines,
            style: textStyle.copyWith(color: textColor),
            cursorColor: cursorColor ?? textColor,
            decoration: InputDecoration(
              isDense: true,
              contentPadding: EdgeInsets.zero,
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
              hintText: placeholder,
              hintStyle: placeholderStyle.copyWith(color: placeholderColor),
            ),
          ),
        ),
        ?suffix,
      ],
    );
  }
}
