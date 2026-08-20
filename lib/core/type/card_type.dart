/// Android `CardType.kt`에 대응.
enum CardType {
  big(imageRatio: 186 / 74),
  small(imageRatio: 155 / 74);

  const CardType({required this.imageRatio});

  final double imageRatio;
}
