import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class HapHapCircularProgressIndicator extends StatelessWidget {
  const HapHapCircularProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(color: AppColors.gray500),
    );
  }
}
