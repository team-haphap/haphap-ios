import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../extensions/no_ripple_clickable.dart';

sealed class FilterChipContent {
  const FilterChipContent();
}

class FilterChipIconContent extends FilterChipContent {
  const FilterChipIconContent(this.iconAsset);

  /// SVG 아이콘 asset 경로.
  final String iconAsset;
}

class FilterChipTextContent extends FilterChipContent {
  const FilterChipTextContent(this.text);

  final String text;
}

/// 필터칩 공용 컴포넌트 — 아이콘 또는 텍스트 중 하나를 표시하며,
/// 선택 상태에 따라 배경색과 텍스트 스타일이 바뀐다.
class HapHapFilterChip extends StatelessWidget {
  const HapHapFilterChip({
    super.key,
    required this.content,
    required this.onFilterClick,
    this.isFilterSelected = false,
  });

  final FilterChipContent content;
  final VoidCallback onFilterClick;
  final bool isFilterSelected;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = isFilterSelected
        ? AppColors.primary100
        : AppColors.gray100;
    final contentColor = isFilterSelected ? AppColors.white : AppColors.gray500;
    final textStyle = isFilterSelected
        ? AppTextStyles.bodySemiBold14
        : AppTextStyles.bodyMedium14;

    return NoRippleClickable(
      onTap: onFilterClick,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(100),
        ),
        alignment: Alignment.center,
        child: switch (content) {
          FilterChipIconContent(:final iconAsset) => SvgPicture.asset(
            iconAsset,
            width: 20,
            height: 20,
            colorFilter: ColorFilter.mode(contentColor, BlendMode.srcIn),
          ),
          FilterChipTextContent(:final text) => Text(
            text,
            style: textStyle.copyWith(color: contentColor),
          ),
        },
      ),
    );
  }
}
