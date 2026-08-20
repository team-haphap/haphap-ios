/// [기획, 디자인, 인사, 영업, 개발/데이터, 금융/보험] — Figma 카테고리 칩 순서.
enum JobCategory {
  planning('기획'),
  design('디자인'),
  hr('인사'),
  sales('영업'),
  devData('개발/데이터'),
  finance('금융/보험');

  const JobCategory(this.label);

  final String label;
}
