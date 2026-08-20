/// Android `RegisterResultType.kt`에 대응. API/도메인용 결과 enum.
enum RegisterResultType {
  pass('PASS'),
  fail('FAIL'),
  pending('PENDING');

  const RegisterResultType(this.apiValue);

  final String apiValue;
}
