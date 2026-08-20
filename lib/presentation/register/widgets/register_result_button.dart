import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/no_ripple_clickable.dart';
import '../type/pass_result_status_button.dart';

/// Android `RegisterResultButton.kt`에 대응.
class RegisterResultButton extends StatelessWidget {
  const RegisterResultButton({
    super.key,
    required this.status,
    required this.isSelected,
    required this.onClick,
  });

  final PassResultStatusButton status;
  final bool isSelected;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    final borderColor = isSelected ? AppColors.sub300 : AppColors.gray100;
    final backgroundColor = isSelected ? AppColors.sub100 : AppColors.white;

    return NoRippleClickable(
      onTap: onClick,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: borderColor, width: 1),
        ),
        padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 14),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              isSelected ? status.selectedBadgeAsset : status.defaultBadgeAsset,
              width: 64,
              height: 64,
            ),
            Text(
              status.text,
              style: AppTextStyles.bodySemiBold14.copyWith(
                color: isSelected ? AppColors.primary500 : AppColors.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
