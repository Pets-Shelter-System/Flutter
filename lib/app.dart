import 'package:flutter/material.dart';
import 'package:pets_shelter_system/routes.dart';
import 'package:pets_shelter_system/shared/theme/app_theme.dart';
import 'package:pets_shelter_system/features/auth/presentation/pages/splash_screen.dart';
import 'package:pets_shelter_system/features/auth/presentation/pages/login_page.dart';
import 'package:pets_shelter_system/features/auth/presentation/pages/register_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'pets_shelter_system',
      theme: AppTheme.theme,
      themeMode: ThemeMode.light,

      initialRoute: AppRoutes.splashScreen.name,

      routes: {
        AppRoutes.registerScreen.name: (context) => const RegisterPage(),
        AppRoutes.loginScreen.name: (context) => const LoginPage(),
        AppRoutes.splashScreen.name: (context) => const SplashScreen(),
      },

      debugShowCheckedModeBanner: false,
    );
  }
}
