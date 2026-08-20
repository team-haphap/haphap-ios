import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/type/button_type.dart';
import '../../../core/widgets/button/haphap_basic_button.dart';
import '../type/notification_channel_type.dart';
import '../widgets/register_enter_date_time.dart';

const _channelColumnCount = 2;

/// Android `RegisterThirdSection.kt` (3단계: 날짜/알림채널)에 대응.
class RegisterThirdSection extends StatelessWidget {
  const RegisterThirdSection({
    super.key,
    required this.contactDate,
    required this.onDateSelected,
    required this.contactTime,
    required this.onTimeSelected,
    required this.selectedChannels,
    required this.onChannelToggled,
  });

  final String? contactDate;
  final ValueChanged<DateTime> onDateSelected;
  final String? contactTime;
  final void Function(int hour, int minute) onTimeSelected;
  final List<NotificationChannelType> selectedChannels;
  final ValueChanged<NotificationChannelType> onChannelToggled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),
          Text(
            '날짜',
            style: AppTextStyles.bodyBold18.copyWith(color: AppColors.gray800),
          ),
          const SizedBox(height: 9),
          RegisterEnterDateTime(
            contactDate: contactDate,
            onDateSelected: onDateSelected,
            contactTime: contactTime,
            onTimeSelected: onTimeSelected,
          ),
          const SizedBox(height: 36),
          Text(
            '알림 채널',
            style: AppTextStyles.bodyBold18.copyWith(color: AppColors.gray800),
          ),
          const SizedBox(height: 9),
          _NotificationChannelGrid(
            selectedChannels: selectedChannels,
            onChannelToggled: onChannelToggled,
          ),
        ],
      ),
    );
  }
}

class _NotificationChannelGrid extends StatelessWidget {
  const _NotificationChannelGrid({
    required this.selectedChannels,
    required this.onChannelToggled,
  });

  final List<NotificationChannelType> selectedChannels;
  final ValueChanged<NotificationChannelType> onChannelToggled;

  @override
  Widget build(BuildContext context) {
    final channels = NotificationChannelType.values;
    final rows = <List<NotificationChannelType>>[];
    for (var i = 0; i < channels.length; i += _channelColumnCount) {
      rows.add(channels.sublist(i, (i + _channelColumnCount).clamp(0, channels.length)));
    }

    return Column(
      children: [
        for (var i = 0; i < rows.length; i++) ...[
          if (i > 0) const SizedBox(height: 8),
          Row(
            children: [
              for (var j = 0; j < _channelColumnCount; j++) ...[
                if (j > 0) const SizedBox(width: 8),
                Expanded(
                  child: j < rows[i].length
                      ? HapHapBasicButton(
                          text: rows[i][j].text,
                          textStyle: AppTextStyles.bodySemiBold14,
                          colorType: selectedChannels.contains(rows[i][j])
                              ? const HapHapButtonTypeSelected()
                              : const HapHapButtonTypeUnSelected(),
                          onClick: () => onChannelToggled(rows[i][j]),
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
