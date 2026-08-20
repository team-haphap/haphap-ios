import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/extensions/no_ripple_clickable.dart';
import '../../../core/widgets/bottomsheet/haphap_date_bottom_sheet.dart';
import '../../../core/widgets/bottomsheet/haphap_time_bottom_sheet.dart';

/// Android `RegisterEnterDateTime.kt`에 대응.
class RegisterEnterDateTime extends StatelessWidget {
  const RegisterEnterDateTime({
    super.key,
    required this.contactDate,
    required this.onDateSelected,
    required this.contactTime,
    required this.onTimeSelected,
  });

  /// "yyyy-MM-dd" 형식.
  final String? contactDate;
  final ValueChanged<DateTime> onDateSelected;

  /// "HH:mm" 형식.
  final String? contactTime;
  final void Function(int hour, int minute) onTimeSelected;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '연락받은 날짜',
                style: AppTextStyles.bodySemiBold14.copyWith(
                  color: AppColors.gray400,
                ),
              ),
              const SizedBox(height: 10),
              _EnterDateField(value: contactDate, onDateSelected: onDateSelected),
            ],
          ),
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '시간대',
                style: AppTextStyles.bodySemiBold14.copyWith(
                  color: AppColors.gray400,
                ),
              ),
              const SizedBox(height: 10),
              _EnterTimeField(value: contactTime, onTimeSelected: onTimeSelected),
            ],
          ),
        ),
      ],
    );
  }
}

class _EnterDateField extends StatelessWidget {
  const _EnterDateField({required this.value, required this.onDateSelected});

  final String? value;
  final ValueChanged<DateTime> onDateSelected;

  @override
  Widget build(BuildContext context) {
    final date = value == null ? null : DateTime.tryParse(value!);
    final display = date == null
        ? null
        : '${date.year}.${date.month.toString().padLeft(2, '0')}.${date.day.toString().padLeft(2, '0')}';
    final color = display == null ? AppColors.gray400 : AppColors.gray600;

    return NoRippleClickable(
      onTap: () async {
        final picked = await showHapHapDateBottomSheet(
          context: context,
          initialDate: date,
        );
        if (picked != null) onDateSelected(picked);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 14),
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                display ?? '연도.월.일',
                style: AppTextStyles.bodySemiBold14.copyWith(color: color),
              ),
            ),
            SvgPicture.asset(
              'assets/icons/register/icn_calendar_18.svg',
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
          ],
        ),
      ),
    );
  }
}

class _EnterTimeField extends StatelessWidget {
  const _EnterTimeField({required this.value, required this.onTimeSelected});

  final String? value;
  final void Function(int hour, int minute) onTimeSelected;

  @override
  Widget build(BuildContext context) {
    TimeOfDay? initial;
    String? display;
    if (value != null) {
      final parts = value!.split(':');
      final hour = int.tryParse(parts[0]);
      final minute = parts.length > 1 ? int.tryParse(parts[1]) : null;
      if (hour != null && minute != null) {
        initial = TimeOfDay(hour: hour, minute: minute);
        display =
            '${hour.toString().padLeft(2, '0')}시 ${minute.toString().padLeft(2, '0')}분';
      }
    }
    final color = display == null ? AppColors.gray400 : AppColors.gray600;

    return NoRippleClickable(
      onTap: () async {
        final picked = await showHapHapTimeBottomSheet(
          context: context,
          initialTime: initial,
        );
        if (picked != null) onTimeSelected(picked.hour, picked.minute);
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: AppColors.gray100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          display ?? '00시 00분',
          textAlign: TextAlign.center,
          style: AppTextStyles.bodySemiBold14.copyWith(color: color),
        ),
      ),
    );
  }
}
