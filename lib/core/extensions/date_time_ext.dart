/// Android `LocalDateExt.kt` / `StringExt.kt`의 날짜 관련 확장 함수에 대응.
extension DateTimeFormatExt on DateTime {
  /// "yyyy-MM-dd" 형식의 문자열로 변환한다. (예: "2026-07-13")
  String toDateString() {
    final y = year.toString().padLeft(4, '0');
    final m = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  /// 날짜 부분(연/월/일)만 남기고 시:분:초를 제거한다. 같은 날짜인지
  /// 비교할 때(`isAtSameMomentAs` 대신) 쓰기 좋다.
  DateTime toDateOnly() => DateTime(year, month, day);

  bool isSameDate(DateTime other) =>
      year == other.year && month == other.month && day == other.day;
}

extension StringToDateTimeExt on String {
  /// "yyyy-MM-dd"(ISO-8601) 형식의 문자열을 [DateTime]으로 변환한다.
  DateTime toLocalDate() => DateTime.parse(this);

  /// ISO-8601 날짜시간 문자열을 "HH:mm" 형식으로 변환한다.
  /// 파싱에 실패하면 빈 문자열을 반환한다.
  String toTimeFormat() {
    try {
      final date = DateTime.parse(this);
      final hh = date.hour.toString().padLeft(2, '0');
      final mm = date.minute.toString().padLeft(2, '0');
      return '$hh:$mm';
    } catch (_) {
      return '';
    }
  }
}
