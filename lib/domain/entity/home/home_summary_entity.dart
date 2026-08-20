/// 홈 현황 요약 카드 3종 (누적 공유 결과 / 진행 중인 공고 / 오늘 발표된 공고).
class HomeSummaryEntity {
  const HomeSummaryEntity({
    required this.sharedResultCount,
    required this.ongoingJobCount,
    required this.announcedTodayCount,
  });

  final int sharedResultCount;
  final int ongoingJobCount;
  final int announcedTodayCount;
}
