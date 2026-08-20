import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../constants/app_colors.dart';
import '../constants/app_text_styles.dart';

enum AppNavTab { home, list, register, calendar, my }

class _NavItemSpec {
  const _NavItemSpec({
    required this.tab,
    required this.label,
    required this.iconAsset,
    this.iconSize = const Size(24, 24),
  });

  final AppNavTab tab;
  final String label;
  final String iconAsset;
  final Size iconSize;
}

const _navItems = [
  _NavItemSpec(
    tab: AppNavTab.home,
    label: '홈',
    iconAsset: 'assets/icons/nav/icn_home.svg',
  ),
  _NavItemSpec(
    tab: AppNavTab.list,
    label: '리스트',
    iconAsset: 'assets/icons/nav/icn_list.svg',
  ),
  _NavItemSpec(
    tab: AppNavTab.register,
    label: '등록',
    iconAsset: 'assets/icons/nav/icn_register.svg',
  ),
  _NavItemSpec(
    tab: AppNavTab.calendar,
    label: '캘린더',
    iconAsset: 'assets/icons/nav/icn_calendar.svg',
    iconSize: Size(16.8, 15.96),
  ),
  _NavItemSpec(
    tab: AppNavTab.my,
    label: '마이',
    iconAsset: 'assets/icons/nav/icn_my.svg',
  ),
];

/// bar_navigation (Figma node 433:9041) — 5-tab bottom navigation bar.
class HapHapNavBar extends StatelessWidget {
  const HapHapNavBar({
    super.key,
    required this.currentTab,
    required this.onTabSelected,
  });

  final AppNavTab currentTab;
  final ValueChanged<AppNavTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.gray100, width: 1)),
      ),
      child: Row(
        children: [
          for (final item in _navItems)
            Expanded(
              child: _NavItem(
                spec: item,
                currentTab: currentTab,
                onTabSelected: onTabSelected,
              ),
            ),
        ],
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.spec,
    required this.currentTab,
    required this.onTabSelected,
  });

  final _NavItemSpec spec;
  final AppNavTab currentTab;
  final ValueChanged<AppNavTab> onTabSelected;

  @override
  Widget build(BuildContext context) {
    final isActive = spec.tab == currentTab;
    final color = isActive ? AppColors.primary500 : AppColors.gray400;

    return InkWell(
      onTap: () => onTabSelected(spec.tab),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 24,
              height: 24,
              child: Center(
                child: SvgPicture.asset(
                  spec.iconAsset,
                  width: spec.iconSize.width,
                  height: spec.iconSize.height,
                  colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
                ),
              ),
            ),
            const SizedBox(height: 6),
            Text(
              spec.label,
              style:
                  (isActive
                          ? AppTextStyles.captionSemiBold12
                          : AppTextStyles.captionMedium12)
                      .copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
