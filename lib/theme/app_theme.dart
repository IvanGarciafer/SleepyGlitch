import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Paleta sacada directamente del logo de Sleepy Glitch.
class SG {
  static const night = Color(0xFF1A1028); // fondo principal (cielo nocturno)
  static const nightAlt = Color(0xFF211533); // fondo de secciones alternas
  static const surface = Color(0xFF2C1B44); // tarjetas
  static const surfaceHigh = Color(0xFF3A2556);
  static const purple = Color(0xFF9D4EA0); // gorro (claro)
  static const purpleDark = Color(0xFF602D60); // gorro (oscuro)
  static const teal = Color(0xFF2CBFBF); // banda y pompón
  static const blush = Color(0xFFCC99C9); // mejillas
  static const ghost = Color(0xFFF3EEF7); // cuerpo del fantasma
  static const ghostDim = Color(0xFFC8C3C0);
  static const textMuted = Color(0xFFB8A9C9);

  static const hatGradient = LinearGradient(
    colors: [purple, purpleDark],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const mono = 'SleepyMono';
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    scaffoldBackgroundColor: SG.night,
    colorScheme: ColorScheme.fromSeed(
      seedColor: SG.purple,
      brightness: Brightness.dark,
      primary: SG.purple,
      secondary: SG.teal,
      surface: SG.surface,
    ),
  );

  final body = GoogleFonts.nunitoTextTheme(base.textTheme).apply(
    bodyColor: SG.ghost,
    displayColor: SG.ghost,
  );

  TextStyle? mono(TextStyle? s) =>
      s?.copyWith(fontFamily: SG.mono, fontWeight: FontWeight.w700);

  return base.copyWith(
    textTheme: body.copyWith(
      displayLarge: mono(body.displayLarge),
      displayMedium: mono(body.displayMedium),
      displaySmall: mono(body.displaySmall),
      headlineLarge: mono(body.headlineLarge),
      headlineMedium: mono(body.headlineMedium),
      headlineSmall: mono(body.headlineSmall),
      titleLarge: mono(body.titleLarge),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: SG.night,
      labelStyle: const TextStyle(color: SG.textMuted),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: SG.surfaceHigh),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: SG.surfaceHigh),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: SG.teal, width: 2),
      ),
    ),
    snackBarTheme: const SnackBarThemeData(
      backgroundColor: SG.surfaceHigh,
      contentTextStyle: TextStyle(color: SG.ghost),
      behavior: SnackBarBehavior.floating,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: SG.surfaceHigh,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: const TextStyle(color: SG.ghost),
    ),
  );
}
