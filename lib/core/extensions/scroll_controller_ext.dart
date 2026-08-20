import 'package:flutter/widgets.dart';

/// Android `LazyListExt.kt`(`LazyGridState.OnBottomReached`)에 대응.
///
/// Android판은 "하단으로부터 몇 번째 *아이템*"을 기준으로 삼지만, Flutter의
/// [ScrollController]는 아이템 인덱스가 아니라 픽셀 오프셋만 알 수 있어서
/// [threshold]는 "하단으로부터 몇 *픽셀*"로 해석한다.
extension OnBottomReachedExt on ScrollController {
  /// 스크롤이 하단 [threshold]px 이내로 도달하면 [onLoadMore]를 호출한다.
  /// 무한 스크롤/페이지네이션 구현에 사용한다.
  ///
  /// 반환된 함수를 `dispose()` 시점에 호출하면 리스너가 해제된다.
  VoidCallback onBottomReached({
    double threshold = 0,
    required bool Function() isLoading,
    required VoidCallback onLoadMore,
  }) {
    assert(threshold >= 0, 'threshold cannot be negative, but was $threshold');

    void listener() {
      if (!hasClients || isLoading()) return;
      final maxScroll = position.maxScrollExtent;
      if (position.pixels >= maxScroll - threshold) onLoadMore();
    }

    addListener(listener);
    return () => removeListener(listener);
  }
}
