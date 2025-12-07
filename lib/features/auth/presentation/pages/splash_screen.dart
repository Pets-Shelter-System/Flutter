import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pets_shelter_system/core/token_storage.dart';
import 'package:pets_shelter_system/shared/theme/app_theme.dart';
import 'package:pets_shelter_system/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    );

    _scaleAnimation = TweenSequence([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.2)
            .chain(CurveTween(curve: Curves.easeOutBack)),
        weight: 70,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 0.9)
            .chain(CurveTween(curve: Curves.easeIn)),
        weight: 30,
      ),
    ]).animate(_controller);

    _fadeAnimation = TweenSequence([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 70),
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 0.0), weight: 30),
    ]).animate(_controller);

    _controller.forward();
    _controller.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        if (mounted) {
          await _navigateToNextScreen();
        }
      }
    });
  }

  Future<void> _navigateToNextScreen() async {
    final token = await TokenStorage.getToken();

    if (!mounted) return;

    if (token != null && token.isNotEmpty) {
      // User logged in before -> go directly to home
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.homeScreen.name,
      );
    } else {
      // No token -> go to login (from there he can go to register)
      Navigator.of(context).pushReplacementNamed(
        AppRoutes.loginScreen.name,
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: SystemUiOverlay.values,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Image.asset(
              AppImages.logo,
              fit: BoxFit.contain,
              width: 350,
            ),
          ),
        ),
      ),
    );
  }
}
