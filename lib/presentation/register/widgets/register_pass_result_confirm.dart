import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../type/pass_result_status_button.dart';

/// Android `RegisterPassResultConfirm.kt`에 대응.
class RegisterPassResultConfirm extends StatelessWidget {
  const RegisterPassResultConfirm({super.key, required this.status});

  final RegisterPassResultType status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: AppColors.sub100,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Center(
            child: Text(
              status.text,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySemiBold14.copyWith(
                color: AppColors.primary500,
              ),
            ),
          ),
          SvgPicture.asset(
            'assets/icons/register/icn_check_18.svg',
            width: 24,
            height: 24,
          ),
        ],
      ),
    );
  }
}
