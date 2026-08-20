import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/no_ripple_clickable.dart';

/// Android `RegisterTnC.kt`에 대응.
class RegisterTnC extends StatelessWidget {
  const RegisterTnC({
    super.key,
    required this.isNecessary,
    required this.contextText,
    required this.onCheckedChange,
    this.checked = false,
  });

  final bool isNecessary;
  final String contextText;
  final ValueChanged<bool> onCheckedChange;
  final bool checked;

  @override
  Widget build(BuildContext context) {
    return NoRippleClickable(
      onTap: () => onCheckedChange(!checked),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              checked
                  ? 'assets/icons/register/icn_check_list_selected_24.svg'
                  : 'assets/icons/register/icn_check_list_default_24.svg',
              width: 24,
              height: 24,
            ),
            const SizedBox(width: 4),
            Text(
              isNecessary ? '(필수)' : '(선택)',
              style: AppTextStyles.captionSemiBold12.copyWith(
                color: AppColors.gray600,
              ),
            ),
            const SizedBox(width: 2),
            Expanded(
              child: Text(
                contextText,
                style: AppTextStyles.captionRegular12.copyWith(
                  color: AppColors.gray600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
