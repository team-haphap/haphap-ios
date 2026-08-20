import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';

class HapHapToast extends StatelessWidget {
  const HapHapToast({super.key, required this.text, required this.isAlarm});

  final String text;
  final bool isAlarm;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.gray600,
        borderRadius: BorderRadius.circular(6),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isAlarm)
            SvgPicture.asset(
              'assets/icons/common/icn_alarm_default.svg',
              width: 32,
              height: 32,
              colorFilter: const ColorFilter.mode(
                AppColors.white,
                BlendMode.srcIn,
              ),
            ),
          const SizedBox(width: 6),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 11),
              child: Text(
                text,
                style: AppTextStyles.bodySemiBold13.copyWith(
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
