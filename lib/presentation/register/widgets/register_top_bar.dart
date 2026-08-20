import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/no_ripple_clickable.dart';

/// Android `RegisterTopBar.kt`에 대응.
class RegisterTopBar extends StatelessWidget {
  const RegisterTopBar({
    super.key,
    required this.onBackClick,
    this.isText = true,
  });

  final VoidCallback onBackClick;
  final bool isText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        children: [
          NoRippleClickable(
            onTap: onBackClick,
            child: SvgPicture.asset(
              'assets/icons/calendar/icn_chevron_left_30.svg',
              width: 30,
              height: 30,
            ),
          ),
          const SizedBox(width: 10),
          if (isText)
            Text(
              '내 상태 등록',
              style: AppTextStyles.subtitleBold20.copyWith(
                color: AppColors.gray800,
              ),
            ),
        ],
      ),
    );
  }
}
