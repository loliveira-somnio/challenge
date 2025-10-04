import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

import '../router/app_router.dart';

class AppView extends StatelessWidget {
  const AppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Challenge App',
      theme: APPTheme().lightTheme,
      darkTheme: APPTheme().darkTheme,
      routerConfig: AppRouter.router,
    );
  }
}
