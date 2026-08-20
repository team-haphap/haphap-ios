import 'package:flutter/material.dart';

/// Typography scale from the Figma design system
/// ("HAP HAP 전체 작업공간" > Typography, node 417:4909).
///
/// These styles carry no color — apply one with `.copyWith(color: ...)`
/// using a token from [AppColors] at the call site.
///
/// Font family defaults to the system font since the Pretendard font
/// files are not bundled in this project yet.
class AppTextStyles {
  static const _fontFamily = 'Pretendard';

  // Title
  static const titleBold30 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 30,
    height: 1.4,
  );
  static const titleBold26 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 26,
    height: 1.4,
  );

  // SubTitle
  static const subtitleBold24 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 24,
    height: 1.3,
  );
  static const subtitleSemiBold24 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 24,
    height: 1.4,
  );
  static const subtitleBold22 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 22,
    height: 1.4,
  );
  static const subtitleBold20 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 20,
    height: 1.4,
  );

  // Body
  static const bodyBold18 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 18,
    height: 1.4,
  );
  static const bodySemiBold18 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 18,
    height: 1.4,
  );
  static const bodyMedium18 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 18,
    height: 1.4,
  );
  static const bodyRegular18 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 18,
    height: 1.4,
  );
  static const bodySemiBold16 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 16,
    height: 1.4,
  );
  static const bodyRegular16 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 1.4,
  );
  static const bodyBold14 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 14,
    height: 1.3,
  );
  static const bodySemiBold14 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 1.4,
  );
  static const bodyMedium14 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 1.4,
  );
  static const bodyRegular14 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 1.4,
  );
  static const bodySemiBold13 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 13,
    height: 1.4,
  );

  // Caption
  static const captionBold12 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w700,
    fontSize: 12,
    height: 1.4,
  );
  static const captionSemiBold12 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 12,
    height: 1.4,
  );
  static const captionMedium12 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 1.4,
  );
  static const captionRegular12 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 1.4,
  );
  static const captionRegular11 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 11,
    height: 1.4,
  );
  static const captionSemiBold10 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w600,
    fontSize: 10,
    height: 1.4,
  );
  static const captionMedium10 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w500,
    fontSize: 10,
    height: 1.3,
  );
  static const captionRegular10 = TextStyle(
    fontFamily: _fontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 10,
    height: 1.4,
  );
}
