import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../extensions/no_ripple_clickable.dart';
import '../../type/card_type.dart';
import '../../type/status_chip_type.dart';
import '../chip/haphap_deadline_chip.dart';
import '../chip/haphap_status_chip.dart';
import '../image/url_image.dart';

/// 공고 카드 공용 컴포넌트. [CardType]에 따라 이미지 비율이 바뀐다.
///
/// @param text 표시할 텍스트(직무/카테고리)
/// @param stage 전형명 (예: 서류, 최종)
/// @param dDay 발표까지 남은 일수
/// @param company 회사명
/// @param description 공고명
class HapHapCard extends StatelessWidget {
  const HapHapCard({
    super.key,
    required this.type,
    required this.imageUrl,
    required this.text,
    required this.stage,
    required this.dDay,
    required this.company,
    required this.description,
    required this.onCardClick,
  });

  final CardType type;
  final String imageUrl;
  final String text;
  final String stage;
  final String dDay;
  final String company;
  final String description;
  final VoidCallback onCardClick;

  @override
  Widget build(BuildContext context) {
    return NoRippleClickable(
      onTap: onCardClick,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(8),
              ),
              child: Stack(
                children: [
                  AspectRatio(
                    aspectRatio: type.imageRatio,
                    child: UrlImage(url: imageUrl, fit: BoxFit.cover),
                  ),
                  Positioned(
                    left: 10,
                    bottom: 8,
                    child: HapHapStatusChip(
                      text: text,
                      type: StatusChipType.category,
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  HapHapDeadlineChip(stage: stage, dDay: dDay),
                  const SizedBox(height: 2),
                  Padding(
                    padding: const EdgeInsets.only(left: 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          company,
                          style: AppTextStyles.bodySemiBold14.copyWith(
                            color: AppColors.gray700,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          description,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.captionSemiBold12.copyWith(
                            color: AppColors.gray600,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
