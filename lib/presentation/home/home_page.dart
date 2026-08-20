import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

/// 홈 (Figma node 2947:14179).
/// TODO: 공용 디자인시스템 컴포넌트(HapHapCard, HapHapFilterChip 등)로 다시 구현.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(backgroundColor: AppColors.white);
  }
}
