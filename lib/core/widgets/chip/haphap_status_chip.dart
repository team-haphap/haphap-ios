import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../type/status_chip_type.dart';

/// 상태칩 공용 컴포넌트 — 배경 sub100, 텍스트 primary500 고정.
/// 타입에 따라 텍스트 스타일만 바뀐다.
class HapHapStatusChip extends StatelessWidget {
  const HapHapStatusChip({super.key, required this.text, required this.type});

  final String text;
  final StatusChipType type;

  TextStyle get _textStyle => switch (type) {
    StatusChipType.category => AppTextStyles.captionSemiBold10,
    StatusChipType.stage => AppTextStyles.captionMedium12,
    StatusChipType.count => AppTextStyles.bodySemiBold14,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.sub100,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        text,
        style: _textStyle.copyWith(color: AppColors.primary500),
      ),
    );
  }
}
