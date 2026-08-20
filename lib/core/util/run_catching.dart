import 'result.dart';

/// Android `suspendRunCatching`에 대응 — 비동기 블록을 안전하게 실행하고
/// 결과를 [Result]로 감싸 반환한다.
///
/// Kotlin판은 코루틴 `CancellationException`을 다시 던져 취소 전파를
/// 보장하지만, Dart의 `Future`는 그런 별도의 취소 예외 개념이 없어서
/// (구독을 취소하면 그냥 콜백이 더 이상 불리지 않을 뿐) 그 부분은
/// 해당사항이 없다 — 나머지 "무슨 에러든 Result로 감싼다"는 동작만 이식.
Future<Result<T>> runCatchingAsync<T>(Future<T> Function() block) async {
  try {
    return Ok(await block());
  } catch (e, stackTrace) {
    return Err(e, stackTrace);
  }
}
