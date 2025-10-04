import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// A class that provides the theme for the app.
class APPTheme {
  /// Light Theme example based on Material 2 Design.
  ThemeData get lightTheme {
    return ThemeData(
      primaryColor: APPColors.skyBlue,
      canvasColor: _backgroundColor,
      scaffoldBackgroundColor: _backgroundColor,
      iconTheme: _lightIconTheme,
      appBarTheme: _lightAppBarTheme,
      textTheme: _lightTextTheme,
      buttonTheme: _buttonTheme,
      splashColor: APPColors.transparent,
      textButtonTheme: _textButtonTheme,
      colorScheme: _lightColorScheme,
      listTileTheme: _listTileTheme,
      bottomNavigationBarTheme: _bottomAppBarTheme,
      dividerColor: APPColors.grey,
    );
  }

  /// Dark Theme example based on Material 2 Design.
  ThemeData get darkTheme => lightTheme.copyWith(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: APPColors.black,
        colorScheme: _darkColorScheme,
        appBarTheme: _darkAppBarTheme,
        disabledColor: APPColors.white.withOpacity(0.5),
        textTheme: _darkTextTheme,
        unselectedWidgetColor: APPColors.lightGrey,
        iconTheme: _darkIconTheme,
        textButtonTheme: _darkTextButtonTheme,
      );

  /// Returns the correct color based on the current theme.
  ColorScheme get _lightColorScheme {
    return ColorScheme.light(
      primary: APPColors.skyBlue,
      primaryContainer: APPColors.lightBlue200,
      onPrimaryContainer: APPColors.oceanBlue,
      secondary: APPColors.paleSky,
      onSecondary: APPColors.white,
      secondaryContainer: APPColors.lightBlue200,
      onSecondaryContainer: APPColors.oceanBlue,
      tertiary: APPColors.secondary.shade700,
      onTertiary: APPColors.white,
      tertiaryContainer: APPColors.secondary.shade300,
      onTertiaryContainer: APPColors.secondary.shade700,
      error: APPColors.red,
      errorContainer: APPColors.red.shade200,
      onErrorContainer: APPColors.redWine,
      inversePrimary: APPColors.crystalBlue,
    );
  }

  /// Returns the correct color based on the current theme.
  ColorScheme get _darkColorScheme => _lightColorScheme.copyWith(
        surface: APPColors.black,
        onSurface: APPColors.lightGrey,
        primary: APPColors.blue,
        onPrimary: APPColors.oceanBlue,
        primaryContainer: APPColors.oceanBlue,
        onPrimaryContainer: APPColors.lightBlue200,
        secondary: APPColors.paleSky,
        onSecondary: APPColors.lightGrey,
        secondaryContainer: APPColors.liver,
        onSecondaryContainer: APPColors.brightGrey,
      );

  /// Returns the correct background color based on the current theme.
  Color get _backgroundColor => APPColors.white;

  /// Returns the correct [AppBarTheme] based on the current theme.
  AppBarTheme get _lightAppBarTheme {
    return AppBarTheme(
      iconTheme: _lightIconTheme,
      titleTextStyle: _lightTextTheme.titleMedium,
      elevation: 0,
      toolbarHeight: 64,
      backgroundColor: APPColors.white,
      toolbarTextStyle: _lightTextTheme.titleLarge,
      systemOverlayStyle: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
    );
  }

  /// Returns the correct [AppBarTheme] based on the current theme.
  AppBarTheme get _darkAppBarTheme {
    return _lightAppBarTheme.copyWith(
      backgroundColor: APPColors.grey,
      iconTheme: _darkIconTheme,
      toolbarTextStyle: _darkTextTheme.titleLarge,
      titleTextStyle: _darkTextTheme.titleMedium,
    );
  }

  /// Returns the correct [IconThemeData] based on the current theme.
  IconThemeData get _lightIconTheme {
    return const IconThemeData(
      color: APPColors.black,
    );
  }

  /// Returns the correct [IconThemeData] based on the current theme.
  IconThemeData get _darkIconTheme {
    return const IconThemeData(
      color: APPColors.white,
    );
  }

  /// Returns the correct [TextTheme] based on the current theme.
  TextTheme get _lightTextTheme => lightUITextTheme;

  /// Returns the correct [TextTheme] based on the current theme.
  TextTheme get _darkTextTheme {
    return _lightTextTheme.apply(
      bodyColor: APPColors.white,
      displayColor: APPColors.white,
      decorationColor: APPColors.white,
    );
  }

  /// The UI text theme based on [APPTextStyle].
  static final lightUITextTheme = TextTheme(
    displayLarge: APPTextStyle.headline1,
    displayMedium: APPTextStyle.headline2,
    displaySmall: APPTextStyle.headline3,
    titleMedium: APPTextStyle.subtitle1,
    titleSmall: APPTextStyle.subtitle2,
    bodyLarge: APPTextStyle.bodyText1,
    bodyMedium: APPTextStyle.bodyText2,
    labelLarge: APPTextStyle.button,
    bodySmall: APPTextStyle.caption,
    labelSmall: APPTextStyle.overline,
  ).apply(
    bodyColor: APPColors.black,
    displayColor: APPColors.black,
    decorationColor: APPColors.black,
  );

  /// Returns the correct [ButtonThemeData] based on the current theme.
  ButtonThemeData get _buttonTheme {
    return ButtonThemeData(
      textTheme: ButtonTextTheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(APPSpacing.sm),
      ),
      padding: const EdgeInsets.symmetric(vertical: APPSpacing.lg),
      buttonColor: APPColors.blue,
      disabledColor: APPColors.lightGrey,
      height: 48,
      minWidth: 48,
    );
  }

  /// Returns the correct [TextButtonThemeData] based on the current theme.
  TextButtonThemeData get _textButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _lightTextTheme.labelLarge?.copyWith(
          fontWeight: APPFontWeight.light,
        ),
        foregroundColor: APPColors.black,
      ),
    );
  }

  /// Returns the correct [TextButtonThemeData] based on the current theme.
  TextButtonThemeData get _darkTextButtonTheme {
    return TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: _lightTextTheme.labelLarge?.copyWith(
          fontWeight: APPFontWeight.light,
        ),
        foregroundColor: APPColors.white,
      ),
    );
  }

  /// Returns the correct [ListTileThemeData] based on the current theme.
  ListTileThemeData get _listTileTheme {
    return const ListTileThemeData(
      iconColor: APPColors.onBackground,
      contentPadding: EdgeInsets.all(APPSpacing.lg),
    );
  }

  /// Returns the correct [BottomNavigationBarThemeData] based on the current
  /// theme.
  BottomNavigationBarThemeData get _bottomAppBarTheme {
    return BottomNavigationBarThemeData(
      backgroundColor: APPColors.black,
      selectedItemColor: APPColors.white,
      unselectedItemColor: APPColors.white.withOpacity(0.74),
    );
  }
}
