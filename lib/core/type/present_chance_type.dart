import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

/// Android `PresentChanceType.kt`에 대응. 캘린더 날짜의 [발표 가능성] 단계.
enum PresentChanceType { none, veryLow, low, medium, high, veryHigh }

extension PresentChanceTypeColor on PresentChanceType {
  Color toColor() {
    return switch (this) {
      PresentChanceType.none => AppColors.gray400,
      PresentChanceType.veryLow => AppColors.sub300,
      PresentChanceType.low => AppColors.sub200,
      PresentChanceType.medium => AppColors.primary100,
      PresentChanceType.high => AppColors.primary500,
      PresentChanceType.veryHigh => AppColors.sub400,
    };
  }
}
