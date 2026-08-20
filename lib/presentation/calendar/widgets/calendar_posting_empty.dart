import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';

/// Android `CalendarListCardEmptyComponent.kt`에 대응.
class CalendarPostingEmpty extends StatelessWidget {
  const CalendarPostingEmpty({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: AppColors.gray100,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/common/icn_alert.svg',
              width: 53,
              height: 53,
              colorFilter: const ColorFilter.mode(
                AppColors.gray200,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              '발표 예상 공고가 없습니다',
              style: AppTextStyles.captionSemiBold12.copyWith(
                color: AppColors.gray400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
