import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Android `RegisterDropDownItemType.kt`에 대응.
enum RegisterDropDownItemType { selected, unselected }

class RegisterDropDownItemStyle {
  const RegisterDropDownItemStyle({
    required this.backgroundColor,
    required this.textColor,
  });

  final Color backgroundColor;
  final Color textColor;
}

extension RegisterDropDownItemTypeStyle on RegisterDropDownItemType {
  RegisterDropDownItemStyle toStyle() {
    return switch (this) {
      RegisterDropDownItemType.selected => const RegisterDropDownItemStyle(
        backgroundColor: AppColors.sub100,
        textColor: AppColors.primary500,
      ),
      RegisterDropDownItemType.unselected => const RegisterDropDownItemStyle(
        backgroundColor: AppColors.gray50,
        textColor: AppColors.gray500,
      ),
    };
  }
}
