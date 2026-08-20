import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../extensions/no_ripple_clickable.dart';

/// 검색바 공용 컴포넌트. 검색 기능 없이 화면 이동을 위한 버튼 역할을 한다.
class HapHapSearchBar extends StatelessWidget {
  const HapHapSearchBar({
    super.key,
    required this.placeholder,
    required this.onSearchBarClick,
  });

  final String placeholder;
  final VoidCallback onSearchBarClick;

  @override
  Widget build(BuildContext context) {
    return NoRippleClickable(
      onTap: onSearchBarClick,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                placeholder,
                style: AppTextStyles.captionMedium12.copyWith(
                  color: AppColors.gray400,
                ),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/common/icn_search.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.gray500,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
