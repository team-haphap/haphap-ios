/// Dart SDK엔 java.time의 `YearMonth`에 대응하는 타입이 없어서 최소한의
/// 버전을 직접 정의한다. 캘린더 월 이동 등에 사용된다.
class YearMonth implements Comparable<YearMonth> {
  const YearMonth(this.year, this.month) : assert(month >= 1 && month <= 12);

  factory YearMonth.from(DateTime date) => YearMonth(date.year, date.month);

  factory YearMonth.now() => YearMonth.from(DateTime.now());

  final int year;
  final int month;

  int get lengthOfMonth => DateTime(year, month + 1, 0).day;

  YearMonth plusMonths(int months) {
    final total = year * 12 + (month - 1) + months;
    return YearMonth(total ~/ 12, total % 12 + 1);
  }

  YearMonth minusMonths(int months) => plusMonths(-months);

  bool isBefore(YearMonth other) => compareTo(other) < 0;

  bool isAfter(YearMonth other) => compareTo(other) > 0;

  /// "yyyy-MM" 형식의 문자열로 변환한다. (예: "2026-07")
  String toDateString() => '$year-${month.toString().padLeft(2, '0')}';

  @override
  int compareTo(YearMonth other) {
    if (year != other.year) return year.compareTo(other.year);
    return month.compareTo(other.month);
  }

  @override
  bool operator ==(Object other) =>
      other is YearMonth && year == other.year && month == other.month;

  @override
  int get hashCode => Object.hash(year, month);

  @override
  String toString() => toDateString();
}
