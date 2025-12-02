import 'package:flutter/material.dart';
import 'package:pets_shelter_system/shared/theme/app_theme.dart';

class CurvedBackground extends StatelessWidget {
  final double height; // The height of the dark blue section
  final Widget? content;
  const CurvedBackground({super.key, required this.height, this.content});

  // Optional content to place inside the dark blue area
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipperWidget(),
      child: Container(
        height: height,
        width: double.infinity,
        color: AppColors.primaryColor, // Dark Blue color
        child: content,
      ),
    );
  }
}

class CustomClipperWidget extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();

    // 1. Start from the top left (0, 0) and draw a line down.
    path.lineTo(0, size.height * 0.7); // Start the curve lower down the screen (70% of height)

    // --- CUBIC BEZIER CURVE ---
    // A Cubic curve requires 2 Control Points (c1 and c2) and 1 End Point (e)

    // Point 1: The high peak of the wave.
    final double x1 = size.width * 0.3; // 30% from the left
    final double y1 = size.height * 0.6; // Higher up (60% of height)

    // Point 2: The low valley of the wave (the inflection point).
    final double x2 = size.width * 0.7; // 70% from the left
    final double y2 = size.height * 0.9; // Lower down (90% of height)

    // End Point: Where the curve finishes.
    final double xe = size.width; // Far right edge
    final double ye = size.height * 0.75; // Finishes at 75% height

    path.cubicTo(x1, y1, x2, y2, xe, ye);

    // 2. Finish the shape by drawing a line to the top right and closing.
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipperWidget oldClipper) => false;
}

// Widget for the PETOPIA Logo and Paw Prints
class LogoSection extends StatefulWidget {
  LogoSection({super.key});

  @override
  State<LogoSection> createState() => _LogoSectionState();
}

class _LogoSectionState extends State<LogoSection> {
  late double screenWidth = MediaQuery.of(context).size.width;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topCenter,
      children: [
        const Positioned(
          top: 70,
          left: 50,
          child: Icon(Icons.pets, color: AppColors.accentColor, size: 32),
        ),
        Positioned(
          top: 50,
          left: screenWidth / 2,
          child: const Icon(Icons.pets, color: AppColors.accentColor, size: 32),
        ),
        const Positioned(
          top: 80,
          right: 60,
          child: Icon(Icons.pets, color: AppColors.accentColor, size: 32),
        ),
        Positioned(
          top: screenWidth * .45,
          left: 60,
          child: const Icon(Icons.pets, color: AppColors.accentColor, size: 32),
        ),
        Positioned(
          top: screenWidth * .35,
          right: 70,
          child: const Icon(Icons.pets, color: AppColors.accentColor, size: 32),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 70.0),
          child: Image.asset(
            AppImages.logo,
            height: 124,
            width: 186,
          ),
        ),
      ],
    );
  }
}
