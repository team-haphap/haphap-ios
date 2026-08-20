import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../constants/app_colors.dart';
import '../../extensions/no_ripple_clickable.dart';

const _rotationDuration = Duration(milliseconds: 500);

/// 탭할 때마다 아이콘이 360도 추가로 회전한다(연속 탭 시 계속 누적 회전).
class HapHapRefreshButton extends StatefulWidget {
  const HapHapRefreshButton({super.key, required this.onButtonClick});

  final VoidCallback onButtonClick;

  @override
  State<HapHapRefreshButton> createState() => _HapHapRefreshButtonState();
}

class _HapHapRefreshButtonState extends State<HapHapRefreshButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: _rotationDuration,
  );
  double _turnsTarget = 0;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _turnsTarget += 1;
    _controller.animateTo(_turnsTarget, curve: Curves.easeInOut);
    widget.onButtonClick();
  }

  @override
  Widget build(BuildContext context) {
    return NoRippleClickable(
      onTap: _handleTap,
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.gray500,
          shape: BoxShape.circle,
        ),
        padding: const EdgeInsets.all(13),
        child: RotationTransition(
          turns: _controller,
          child: SvgPicture.asset(
            'assets/icons/common/icn_refresh.svg',
            width: 18,
            height: 18,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
