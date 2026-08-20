import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/haphap_nav_bar.dart';

class NavigationNotifier extends AutoDisposeNotifier<AppNavTab> {
  @override
  AppNavTab build() => AppNavTab.home;

  void setTab(AppNavTab tab) => state = tab;
}
