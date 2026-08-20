import 'package:flutter/material.dart';

/// Android `Modifier.noRippleClickable`에 대응 — 리플 효과 없이 탭 가능하게 만든다.
class NoRippleClickable extends StatelessWidget {
  const NoRippleClickable({
    super.key,
    required this.onTap,
    required this.child,
    this.isEnabled = true,
  });

  final VoidCallback onTap;
  final Widget child;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: isEnabled ? onTap : null,
      child: child,
    );
  }
}
