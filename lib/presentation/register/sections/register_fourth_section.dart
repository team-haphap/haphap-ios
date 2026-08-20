import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../type/pass_result_status_button.dart';
import '../widgets/register_pass_result_confirm.dart';
import '../widgets/register_result_confirm.dart';
import '../widgets/register_tnc.dart';

/// Android `RegisterFourthSection.kt` (4단계: 확인)에 대응.
class RegisterFourthSection extends StatelessWidget {
  const RegisterFourthSection({
    super.key,
    required this.recruitName,
    required this.recruitProcess,
    required this.selectedResult,
    required this.contactDate,
    required this.contactTime,
    required this.isAlarmAgreed,
    required this.onAlarmAgreeToggled,
    required this.isTermAgreed,
    required this.onTermAgreeToggled,
  });

  final String recruitName;
  final String recruitProcess;
  final PassResultStatusButton? selectedResult;

  /// "yyyy-MM-dd" 형식.
  final String? contactDate;

  /// "HH:mm" 형식.
  final String? contactTime;
  final bool isAlarmAgreed;
  final ValueChanged<bool> onAlarmAgreeToggled;
  final bool isTermAgreed;
  final ValueChanged<bool> onTermAgreeToggled;

  @override
  Widget build(BuildContext context) {
    final date = contactDate == null ? null : DateTime.tryParse(contactDate!);
    final dateText = date == null
        ? null
        : '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';

    String? timeText;
    if (contactTime != null) {
      final parts = contactTime!.split(':');
      if (parts.length >= 2) {
        timeText = '${parts[0].padLeft(2, '0')}시 ${parts[1].padLeft(2, '0')}분';
      }
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '입력한 정보를 확인해 주세요',
            style: AppTextStyles.bodyBold18.copyWith(color: AppColors.gray800),
          ),
          const SizedBox(height: 15),
          RegisterResultConfirm(
            recruitName: recruitName,
            recruitProcess: recruitProcess,
          ),
          const SizedBox(height: 36),
          Text(
            selectedResult == PassResultStatusButton.dontKnow ? '결과' : '날짜 및 결과',
            style: AppTextStyles.bodyBold18.copyWith(color: AppColors.gray800),
          ),
          const SizedBox(height: 15),
          if (dateText != null && timeText != null) ...[
            Row(
              children: [
                Expanded(child: _ConfirmInfoBox(text: dateText)),
                const SizedBox(width: 12),
                Expanded(child: _ConfirmInfoBox(text: timeText)),
              ],
            ),
            const SizedBox(height: 12),
          ],
          RegisterPassResultConfirm(
            status: (selectedResult ?? PassResultStatusButton.dontKnow)
                .toPassResultType(),
          ),
          const Expanded(child: SizedBox()),
          RegisterTnC(
            isNecessary: false,
            contextText: '같은 공고의 발표가 감지되면 알림을 받습니다.',
            checked: isAlarmAgreed,
            onCheckedChange: onAlarmAgreeToggled,
          ),
          RegisterTnC(
            isNecessary: true,
            contextText:
                '내 상태는 부여된 닉네임으로 익명 등록되며, 중복·허위 등록 방지를 위해 기기 단위의 최소 검증이 적용됩니다.',
            checked: isTermAgreed,
            onCheckedChange: onTermAgreeToggled,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}

class _ConfirmInfoBox extends StatelessWidget {
  const _ConfirmInfoBox({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.gray100,
        borderRadius: BorderRadius.circular(8),
      ),
      alignment: Alignment.center,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: AppTextStyles.bodySemiBold14.copyWith(color: AppColors.gray600),
      ),
    );
  }
}
