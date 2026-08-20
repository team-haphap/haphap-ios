import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../extensions/no_ripple_clickable.dart';
import '../../type/button_type.dart';

class _HapHapButtonStyle {
  const _HapHapButtonStyle({
    required this.backgroundColor,
    required this.textColor,
    Color? disabledBackgroundColor,
    Color? disabledTextColor,
  }) : disabledBackgroundColor = disabledBackgroundColor ?? backgroundColor,
       disabledTextColor = disabledTextColor ?? textColor;

  final Color backgroundColor;
  final Color textColor;
  final Color disabledBackgroundColor;
  final Color disabledTextColor;
}

_HapHapButtonStyle _styleOf(HapHapButtonType type) {
  return switch (type) {
    HapHapButtonTypePrimary() => const _HapHapButtonStyle(
      backgroundColor: AppColors.primary500,
      textColor: AppColors.white,
      disabledBackgroundColor: AppColors.gray300,
    ),
    HapHapButtonTypeCancel() => const _HapHapButtonStyle(
      backgroundColor: AppColors.gray100,
      textColor: AppColors.gray400,
    ),
    HapHapButtonTypeSelected() => const _HapHapButtonStyle(
      backgroundColor: AppColors.sub100,
      textColor: AppColors.primary500,
    ),
    HapHapButtonTypeUnSelected() => const _HapHapButtonStyle(
      backgroundColor: AppColors.gray100,
      textColor: AppColors.gray400,
    ),
  };
}

bool _isEnabledOf(HapHapButtonType type) {
  return switch (type) {
    HapHapButtonTypePrimary(:final enabled) => enabled,
    HapHapButtonTypeCancel() => true,
    HapHapButtonTypeSelected() => true,
    HapHapButtonTypeUnSelected() => true,
  };
}

/// HapHap 공용 버튼의 기본 형태(base) 컴포넌트.
///
/// Large/Medium/Small 버튼은 모양(padding, radius, 클릭 처리)이 동일하고
/// 텍스트 스타일과 색상 조합만 다르므로 이 컴포넌트를 공통으로 사용한다.
class HapHapBasicButton extends StatelessWidget {
  const HapHapBasicButton({
    super.key,
    required this.text,
    required this.textStyle,
    required this.colorType,
    required this.onClick,
  });

  final String text;
  final TextStyle textStyle;
  final HapHapButtonType colorType;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final style = _styleOf(colorType);
    final isEnabled = _isEnabledOf(colorType);

    return NoRippleClickable(
      onTap: onClick,
      isEnabled: isEnabled,
      child: Container(
        decoration: BoxDecoration(
          color: isEnabled
              ? style.backgroundColor
              : style.disabledBackgroundColor,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 12),
        alignment: Alignment.center,
        child: Text(
          text,
          style: textStyle.copyWith(
            color: isEnabled ? style.textColor : style.disabledTextColor,
          ),
        ),
      ),
    );
  }
}
