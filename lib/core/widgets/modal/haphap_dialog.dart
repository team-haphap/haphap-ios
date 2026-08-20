import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import '../../type/button_type.dart';
import '../button/haphap_basic_button.dart';

/// 취소/확인 버튼이 있는 알림용 다이얼로그.
///
/// @param content 다이얼로그 본문에 표시할 안내 문구
/// @param onDismiss 다이얼로그 바깥 영역 또는 "취소" 버튼 클릭 시 호출되는 콜백
/// @param onConfirmClick "확인" 버튼 클릭 시 호출되는 콜백
class HapHapDialog extends StatelessWidget {
  const HapHapDialog({
    super.key,
    required this.content,
    required this.onDismiss,
    required this.onConfirmClick,
  });

  final String content;
  final VoidCallback onDismiss;
  final VoidCallback onConfirmClick;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 21),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/common/icn_alert.svg',
              colorFilter: const ColorFilter.mode(
                AppColors.gray200,
                BlendMode.srcIn,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              content,
              textAlign: TextAlign.center,
              style: AppTextStyles.bodySemiBold16.copyWith(
                color: AppColors.gray700,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: HapHapBasicButton(
                    text: '취소',
                    textStyle: AppTextStyles.bodySemiBold18,
                    colorType: const HapHapButtonTypeCancel(),
                    onClick: onDismiss,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: HapHapBasicButton(
                    text: '확인',
                    textStyle: AppTextStyles.bodySemiBold18,
                    colorType: const HapHapButtonTypePrimary(),
                    onClick: onConfirmClick,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// [HapHapDialog]를 모달로 띄운다. 바깥 영역을 탭하면 [HapHapDialog.onDismiss]와
/// 동일하게 취소로 처리된다.
Future<void> showHapHapDialog({
  required BuildContext context,
  required String content,
  required VoidCallback onConfirmClick,
}) {
  return showDialog<void>(
    context: context,
    builder: (context) => HapHapDialog(
      content: content,
      onDismiss: () => Navigator.of(context).pop(),
      onConfirmClick: onConfirmClick,
    ),
  );
}
