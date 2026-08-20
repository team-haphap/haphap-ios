import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/type/button_type.dart';
import '../../../core/widgets/button/haphap_basic_button.dart';
import '../../../data/model/register/register_dropdown_item_model.dart';
import '../../../data/model/register/register_process_model.dart';
import '../register_ui_state.dart';
import '../widgets/register_dropdown.dart';

const _processColumnCount = 3;

/// Android `RegisterFirstSection.kt` (1단계: 공고/전형)에 대응.
class RegisterFirstSection extends StatelessWidget {
  const RegisterFirstSection({
    super.key,
    required this.announceList,
    required this.selectedAnnounce,
    required this.onAnnounceSelected,
    required this.processList,
    required this.processListUiState,
    required this.selectedProcessId,
    required this.onProcessSelected,
  });

  final List<RegisterDropDownItemModel> announceList;
  final RegisterDropDownItemModel? selectedAnnounce;
  final ValueChanged<RegisterDropDownItemModel> onAnnounceSelected;
  final List<RegisterProcessModel> processList;
  final RegisterUiState processListUiState;
  final int? selectedProcessId;
  final ValueChanged<int> onProcessSelected;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            '공고',
            style: AppTextStyles.bodyBold18.copyWith(color: AppColors.gray800),
          ),
          const SizedBox(height: 9),
          RegisterDropDown(
            items: announceList,
            selectedItem: selectedAnnounce,
            onItemSelected: onAnnounceSelected,
            placeholder: '원하는 공고를 선택해주세요',
          ),
          if (selectedAnnounce != null) ...[
            const SizedBox(height: 36),
            Text(
              '전형',
              style: AppTextStyles.bodyBold18.copyWith(
                color: AppColors.gray800,
              ),
            ),
            const SizedBox(height: 9),
            if (processListUiState is RegisterUiStateSuccess)
              _ProcessButtonGrid(
                processList: processList,
                selectedProcessId: selectedProcessId,
                onProcessSelected: onProcessSelected,
              ),
          ],
        ],
      ),
    );
  }
}

class _ProcessButtonGrid extends StatelessWidget {
  const _ProcessButtonGrid({
    required this.processList,
    required this.selectedProcessId,
    required this.onProcessSelected,
  });

  final List<RegisterProcessModel> processList;
  final int? selectedProcessId;
  final ValueChanged<int> onProcessSelected;

  @override
  Widget build(BuildContext context) {
    final rows = <List<RegisterProcessModel>>[];
    for (var i = 0; i < processList.length; i += _processColumnCount) {
      rows.add(
        processList.sublist(
          i,
          (i + _processColumnCount).clamp(0, processList.length),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) const SizedBox(height: 4),
          Row(
            children: [
              for (var j = 0; j < _processColumnCount; j++) ...[
                if (j > 0) const SizedBox(width: 4),
                Expanded(
                  child: j < rows[i].length
                      ? HapHapBasicButton(
                          text: rows[i][j].text,
                          textStyle: AppTextStyles.bodySemiBold14,
                          colorType: rows[i][j].id == selectedProcessId
                              ? const HapHapButtonTypeSelected()
                              : const HapHapButtonTypeUnSelected(),
                          onClick: () => onProcessSelected(rows[i][j].id),
                        )
                      : const SizedBox.shrink(),
                ),
              ],
            ],
          ),
        ],
      ],
    );
  }
}
