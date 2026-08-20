import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'splash_notifier.dart';

final splashProvider =
    NotifierProvider.autoDispose<SplashNotifier, SplashState>(
      SplashNotifier.new,
    );
