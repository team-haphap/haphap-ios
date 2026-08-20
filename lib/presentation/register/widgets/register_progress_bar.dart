import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';

/// Android `RegisterProgressBar.kt`에 대응.
class RegisterProgressBar extends StatelessWidget {
  const RegisterProgressBar({
    super.key,
    required this.progress,
    this.totalSteps = 3,
  });

  final int progress;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 17),
      child: Row(
        children: [
          for (var i = 0; i < totalSteps; i++) ...[
            if (i > 0) const SizedBox(width: 6),
            Expanded(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: i < progress ? AppColors.gray700 : AppColors.gray200,
                  borderRadius: BorderRadius.circular(3),
                ),
                child: const SizedBox(height: 6),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
