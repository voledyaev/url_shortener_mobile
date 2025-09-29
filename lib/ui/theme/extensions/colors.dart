import 'package:flutter/material.dart';

@immutable
class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.charcoal,
  });

  static const all = AppColors(
    charcoal: _charcoal,
  );

  static const _charcoal = Color(0xFF2E4756);

  final Color charcoal;

  static AppColors of(BuildContext context) {
    return Theme.of(context).extension<AppColors>()!;
  }

  @override
  ThemeExtension<AppColors> copyWith({
    Color? charcoal,
  }) {
    return AppColors(
      charcoal: charcoal ?? this.charcoal,
    );
  }

  @override
  ThemeExtension<AppColors> lerp(covariant ThemeExtension<AppColors>? other, double t) {
    if (other is! AppColors) return this;

    return AppColors(
      charcoal: Color.lerp(charcoal, other.charcoal, t)!,
    );
  }
}

extension AppColorsX on BuildContext {
  AppColors get colors => AppColors.of(this);
}
