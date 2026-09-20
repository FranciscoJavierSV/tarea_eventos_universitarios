import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    // Palette provided by user:
    // deep blue: #000A7A, primary blue: #164D73, mid gray: #666666, dark: #292929, light gray: #B4B4B4
    final primaryBlue = const Color(0xFF164D73);
    final darkBlue = const Color(0xFF000A7A);
    final darkBase = const Color(0xFF292929);
    final cardBg = const Color(0xFF1E1E1E);
    final borderLight = const Color(0xFFB4B4B4);

    final scheme = ColorScheme.dark(
      primary: primaryBlue,
      onPrimary: Colors.white,
      secondary: darkBlue,
      surface: cardBg,
      onSurface: Colors.white70,
      background: darkBase,
      onBackground: Colors.white,
      error: Colors.red.shade400,
      brightness: Brightness.dark,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: scheme,
      // Fondo general gris oscuro neutral (según paleta)
      scaffoldBackgroundColor: darkBase,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: darkBlue.withOpacity(0.96),
        foregroundColor: scheme.onPrimary,
      ),
      // CardTheme: tarjetas ligeramente más claras que el fondo para contraste (gris oscuro)
      cardTheme: CardThemeData(
        color: cardBg,
        elevation: 3,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: borderLight.withOpacity(0.12)),
        ),
      ),
      // Botones con color primario para buen contraste
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) {
            if (states.contains(MaterialState.pressed) || states.contains(MaterialState.hovered)) {
              return const Color(0xFF000A7A);
            }
            return scheme.primary;
          }),
          foregroundColor: MaterialStateProperty.all(scheme.onPrimary),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(borderRadius: BorderRadius.circular(8))),
        ),
      ),
      // Texto claro para fondo oscuro
      textTheme: ThemeData.dark().textTheme.copyWith(
            headlineSmall: ThemeData.dark().textTheme.headlineSmall?.copyWith(color: Colors.white),
            titleLarge: ThemeData.dark().textTheme.titleLarge?.copyWith(color: Colors.white),
            titleMedium: ThemeData.dark().textTheme.titleMedium?.copyWith(color: Colors.white70),
            bodyLarge: ThemeData.dark().textTheme.bodyLarge?.copyWith(color: Colors.white70),
            bodyMedium: ThemeData.dark().textTheme.bodyMedium?.copyWith(color: Colors.white60),
          ),
      iconTheme: IconThemeData(color: scheme.primary),
    );
  }
}
