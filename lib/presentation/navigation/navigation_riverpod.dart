import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/widgets/haphap_nav_bar.dart';
import 'navigation_notifier.dart';

final navigationProvider =
    AutoDisposeNotifierProvider<NavigationNotifier, AppNavTab>(
      NavigationNotifier.new,
    );
