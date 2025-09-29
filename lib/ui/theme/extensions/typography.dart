import 'package:flutter/material.dart';
import 'package:url_shortener/gen/fonts.gen.dart';

@immutable
class AppTypography extends ThemeExtension<AppTypography> {
  const AppTypography({
    required this.medium,
  });

  static const all = AppTypography(
    medium: _medium,
  );

  static const _medium = TextStyle(
    fontFamily: FontFamily.roboto,
    fontWeight: FontWeight.w500,
  );

  final TextStyle medium;

  static AppTypography of(BuildContext context) {
    return Theme.of(context).extension<AppTypography>()!;
  }

  @override
  ThemeExtension<AppTypography> copyWith({
    TextStyle? medium,
  }) {
    return AppTypography(
      medium: medium ?? this.medium,
    );
  }

  @override
  ThemeExtension<AppTypography> lerp(covariant ThemeExtension<AppTypography>? other, double t) {
    if (other is! AppTypography) return this;

    return AppTypography(
      medium: TextStyle.lerp(medium, other.medium, t)!,
    );
  }
}

extension AppTypographyX on BuildContext {
  AppTypography get typography => AppTypography.of(this);
}
