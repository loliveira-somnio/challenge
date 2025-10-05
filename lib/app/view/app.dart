import 'package:app_ui/app_ui.dart';
import 'package:challenge/l10n/app_localizations.dart';
// import 'package:challenge/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import '../router/app_router.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        AppLocalizations.delegate,
      ],
      supportedLocales: [Locale('en', 'US'), Locale('pt', 'BR')],
      title: 'Challenge App',
      theme: APPTheme().lightTheme,
      darkTheme: APPTheme().darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
