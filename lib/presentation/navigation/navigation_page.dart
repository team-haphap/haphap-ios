import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_text_styles.dart';
import '../../core/widgets/haphap_nav_bar.dart';
import '../calendar/calendar_page.dart';
import '../home/home_page.dart';
import '../register/register_page.dart';
import 'navigation_riverpod.dart';

/// 5개 탭(홈/리스트/등록/캘린더/마이)을 호스팅한다.
/// 홈/등록/캘린더 탭만 실제 화면이 있고, 나머지는 디자인이 나올 때까지 placeholder.
class NavigationPage extends ConsumerWidget {
  const NavigationPage({super.key});

  static const Map<AppNavTab, Widget> _pages = {
    AppNavTab.home: HomePage(),
    AppNavTab.list: _PlaceholderTab(label: '리스트'),
    AppNavTab.register: RegisterPage(),
    AppNavTab.calendar: CalendarPage(),
    AppNavTab.my: _PlaceholderTab(label: '마이'),
  };

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTab = ref.watch(navigationProvider);

    /// Android `MainScreen.kt`의 `isBottomBarVisible`에 대응 — 등록 탭은
    /// 자체 하단 CTA 버튼을 쓰므로 공용 5탭 바를 숨긴다.
    final isBottomBarVisible = currentTab != AppNavTab.register;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: IndexedStack(
          index: AppNavTab.values.indexOf(currentTab),
          children: AppNavTab.values.map((tab) => _pages[tab]!).toList(),
        ),
      ),
      bottomNavigationBar: isBottomBarVisible
          ? SafeArea(
              top: false,
              child: HapHapNavBar(
                currentTab: currentTab,
                onTabSelected: (tab) =>
                    ref.read(navigationProvider.notifier).setTab(tab),
              ),
            )
          : null,
    );
  }
}

class _PlaceholderTab extends StatelessWidget {
  const _PlaceholderTab({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        label,
        style: AppTextStyles.subtitleBold22.copyWith(color: AppColors.gray400),
      ),
    );
  }
}
