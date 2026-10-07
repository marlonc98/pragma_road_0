import 'package:flutter/material.dart';
import 'package:mi_perfil_dev/presentation/router.dart';
import 'package:mi_perfil_dev/presentation/theme/dark_theme.dart';
import 'package:mi_perfil_dev/presentation/theme/light_theme.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: "Mi Perfil Dev",
      theme: lightTheme,
      darkTheme: darkTheme,
      routerConfig: router,
    );
  }
}
