import 'package:flutter/material.dart';
import 'package:pets_shelter_system/routes.dart';
import 'package:pets_shelter_system/ui/design/design.dart';
import 'package:pets_shelter_system/ui/login/login.dart';
import 'package:pets_shelter_system/ui/register/register.dart';



void main()  {
  WidgetsFlutterBinding.ensureInitialized();



  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'pets_shelter_system',
      theme: AppTheme.theme,
      themeMode: ThemeMode.light,
      initialRoute: AppRoutes.registerScreen.name,
      routes: {
        AppRoutes.registerScreen.name :(context) => RegisterScreen(),
        AppRoutes.loginScreen.name : (context) => loginScreen(),
      },
    );
  }
}