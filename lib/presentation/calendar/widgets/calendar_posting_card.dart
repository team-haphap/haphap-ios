import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/no_ripple_clickable.dart';
import '../../../core/widgets/image/url_image.dart';
import '../../../data/model/calendar/calendar_posting_model.dart';
import 'calendar_status_chip.dart';

/// Android `CalendarListCardComponent.kt`에 대응. 선택한 날짜의 공고 카드 한 줄.
class CalendarPostingCard extends StatelessWidget {
  const CalendarPostingCard({
    super.key,
    required this.posting,
    required this.onTap,
  });

  final CalendarPostingModel posting;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return NoRippleClickable(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    posting.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.bodySemiBold14.copyWith(
                      color: AppColors.gray800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CalendarStatusChip(
                        chipText: '${posting.stageName} 발표 예상',
                        isExpectedStage: true,
                      ),
                      const SizedBox(width: 6),
                      CalendarStatusChip(
                        chipText: '${posting.participantCount}명 참여중',
                        isExpectedStage: false,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '과거 유사 공고 흐름을 바탕으로 예상했어요!',
                    style: AppTextStyles.captionRegular10.copyWith(
                      color: AppColors.gray500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: AppColors.gray100, width: 1),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(9),
                child: UrlImage(
                  url: posting.logoImageUrl,
                  fit: BoxFit.contain,
                  width: 64,
                  height: 64,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
