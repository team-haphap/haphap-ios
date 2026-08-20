import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_text_styles.dart';
import 'haphap_picker.dart';

/// HapHap 공용 휠 피커 바텀시트.
///
/// [content]는 [HapHapPicker] 휠들을 나열한 `Row`. 안드로이드판과 달리
/// Flutter의 휠은 높이를 미리 고정값([itemExtent])으로 받기 때문에
/// 런타임 측정 콜백 없이 그 값으로 가운데 강조 배경 높이를 맞춘다.
///
/// 바깥 영역 탭이나 시스템 뒤로가기로 닫히면(취소 처리) `null`을 반환하고,
/// [showHapHapBottomSheet]를 통해 열렸다면 "확인" 시 반환값이 전달된다.
class HapHapBottomSheet extends StatelessWidget {
  const HapHapBottomSheet({
    super.key,
    required this.content,
    required this.onCancel,
    required this.onConfirm,
    this.itemExtent = kPickerItemExtent,
  });

  final Widget content;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;
  final double itemExtent;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: itemExtent,
                    decoration: BoxDecoration(
                      color: AppColors.gray100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  content,
                ],
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: _SheetButton(
                      label: '취소',
                      isPrimary: false,
                      onTap: onCancel,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _SheetButton(
                      label: '확인',
                      isPrimary: true,
                      onTap: onConfirm,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SheetButton extends StatelessWidget {
  const _SheetButton({
    required this.label,
    required this.isPrimary,
    required this.onTap,
  });

  final String label;
  final bool isPrimary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 49,
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          backgroundColor: isPrimary ? AppColors.primary500 : AppColors.gray100,
          foregroundColor: isPrimary ? AppColors.white : AppColors.gray700,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        child: Text(label, style: AppTextStyles.bodyBold18),
      ),
    );
  }
}

/// [HapHapBottomSheet]를 모달로 띄운다.
///
/// 안드로이드판과 동일하게 드래그로는 닫히지 않고(바깥 탭 / 뒤로가기만
/// 가능), 그렇게 닫히면 취소로 취급되어 `null`이 반환된다.
Future<T?> showHapHapBottomSheet<T>({
  required BuildContext context,
  required Widget Function(BuildContext context) builder,
}) {
  return showModalBottomSheet<T>(
    context: context,
    isDismissible: true,
    enableDrag: false,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: builder,
  );
}
