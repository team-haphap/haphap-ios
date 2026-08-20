import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../extensions/no_ripple_clickable.dart';
import 'haphap_basic_text_field.dart';

/// 검색 텍스트 필드 공용 컴포넌트.
class HapHapSearchTextField extends StatelessWidget {
  const HapHapSearchTextField({
    super.key,
    required this.controller,
    required this.placeholder,
    required this.onSearch,
    this.focusNode,
  });

  final TextEditingController controller;
  final String placeholder;
  final VoidCallback onSearch;
  final FocusNode? focusNode;

  void _handleSearch(BuildContext context) {
    onSearch();
    FocusScope.of(context).unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(8),
      ),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
      child: HapHapBasicTextField(
        controller: controller,
        focusNode: focusNode,
        textColor: AppColors.gray800,
        textStyle: AppTextStyles.bodyMedium14,
        placeholder: placeholder,
        placeholderColor: AppColors.gray400,
        placeholderStyle: AppTextStyles.captionMedium12,
        textInputAction: TextInputAction.search,
        onSubmitted: (_) => _handleSearch(context),
        suffix: NoRippleClickable(
          onTap: () => _handleSearch(context),
          child: SvgPicture.asset(
            'assets/icons/common/icn_search.svg',
            colorFilter: const ColorFilter.mode(
              AppColors.gray500,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
