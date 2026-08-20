import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/navigator_ext.dart';
import '../../../core/extensions/no_ripple_clickable.dart';
import '../../../core/widgets/image/url_image.dart';
import '../../../data/model/register/register_pass_card_model.dart';
import '../../navigation/navigation_page.dart';

/// Android `RegisterPassCardScreen.kt`에 대응. 합격 등록 후 보여주는
/// 축하 카드 화면 — 등록 탭 위에 별도 destination으로 push된다.
class RegisterPassCardPage extends StatelessWidget {
  const RegisterPassCardPage({super.key, required this.passCard});

  final RegisterPassCardModel passCard;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 36),
              Text(
                '${passCard.userName}님의 합격을 축하드려요!',
                style: AppTextStyles.subtitleBold22.copyWith(
                  color: AppColors.gray800,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                '기다려온 순간, 진심으로 축하드려요',
                style: AppTextStyles.bodySemiBold13.copyWith(
                  color: AppColors.gray400,
                ),
              ),
              const SizedBox(height: 31),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: AspectRatio(
                  aspectRatio: 312 / 540,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        UrlImage(
                          url: passCard.backgroundImageUrl,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 22,
                            right: 22,
                            top: 26,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              UrlImage(
                                url: passCard.logoUrl,
                                fit: BoxFit.contain,
                                height: 44,
                              ),
                              const SizedBox(height: 12),
                              Text(
                                '${passCard.companyName} ${passCard.recruitName}',
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.bodyBold18.copyWith(
                                  color: AppColors.primary100,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
              NoRippleClickable(
                onTap: () => Navigator.of(context).pushAndClearBackStack(
                  const NavigationPage(),
                ),
                child: SizedBox(
                  width: double.infinity,
                  child: Text(
                    '홈으로',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.bodySemiBold13.copyWith(
                      color: AppColors.gray300,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 37),
            ],
          ),
        ),
      ),
    );
  }
}
