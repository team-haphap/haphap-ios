/// Dart SDK엔 Kotlin의 `Result<T>` 같은 표준 타입이 없어서 최소한의
/// 버전을 직접 정의한다. [runCatchingAsync]와 짝을 이룬다.
sealed class Result<T> {
  const Result();
}

class Ok<T> extends Result<T> {
  const Ok(this.value);

  final T value;
}

class Err<T> extends Result<T> {
  const Err(this.error, [this.stackTrace]);

  final Object error;
  final StackTrace? stackTrace;
}
