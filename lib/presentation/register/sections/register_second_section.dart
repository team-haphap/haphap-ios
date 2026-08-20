import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../type/pass_result_status_button.dart';
import '../widgets/register_result_button.dart';

/// Android `RegisterSecondSection.kt` (2단계: 결과)에 대응.
///
/// 결과 변경 확인 모달(`isChangeModalVisible`)은 한 번만 떠야 하므로 이
/// 위젯이 아니라 [RegisterPage]에서 `ref.listen`으로 띄운다.
class RegisterSecondSection extends StatelessWidget {
  const RegisterSecondSection({
    super.key,
    required this.selectedResult,
    required this.onResultSelected,
  });

  final PassResultStatusButton? selectedResult;
  final ValueChanged<PassResultStatusButton> onResultSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            '결과',
            style: AppTextStyles.bodyBold18.copyWith(color: AppColors.gray800),
          ),
          const SizedBox(height: 9),
          Row(
            children: [
              for (var i = 0; i < PassResultStatusButton.values.length; i++) ...[
                if (i > 0) const SizedBox(width: 10),
                Expanded(
                  child: RegisterResultButton(
                    status: PassResultStatusButton.values[i],
                    isSelected: PassResultStatusButton.values[i] == selectedResult,
                    onClick: () =>
                        onResultSelected(PassResultStatusButton.values[i]),
                  ),
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
