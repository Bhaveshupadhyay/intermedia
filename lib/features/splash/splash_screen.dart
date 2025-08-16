import 'dart:async';
import 'dart:math'; // For pi
import 'package:flutter/material.dart';

import '../../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin {
  late AnimationController _overallController; // Controls all animations
  late Animation<double> _animation; // The main animation value
  late Animation<double> _perspectiveAnimation; // For the 3D perspective effect

  @override
  void initState() {
    super.initState();

    _overallController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3000), // Total animation duration
    );

    // Main animation curve, starting slow, speeding up, then settling
    _animation = CurvedAnimation(
      parent: _overallController,
      curve: const Interval(0.0, 1.0, curve: Curves.easeInOutSine), // Smooth overall curve
    );

    // Perspective animation: makes the 3D effect appear and disappear
    _perspectiveAnimation = CurvedAnimation(
      parent: _overallController,
      curve: const Interval(0.1, 0.9, curve: Curves.easeOutCubic), // 3D effect is prominent in the middle
    );

    _overallController.forward(); // Start the animation

    // Navigate to the main app after the animation completes
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const MyHomePage()), // Navigate to your main app screen
      );
    });
  }

  @override
  void dispose() {
    _overallController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black, // Netflix-like dark background
      body: Center(
        child: AnimatedBuilder(
          animation: _overallController,
          builder: (context, child) {
            // Apply a global perspective transform to the entire row of letters
            // This makes objects further back appear smaller, creating a 3D illusion
            final Matrix4 perspective = Matrix4.identity()
              ..setEntry(3, 2, 0.003); // This value controls the strength of the perspective (0.001 to 0.005 usually)

            return Transform(
              alignment: FractionalOffset.center,
              transform: perspective,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate("IJINLE".length, (index) {
                  final String letter = "IJINLE"[index];
                  final double numLetters = "IJINLE".length.toDouble();

                  // Normalized position of the letter in the word (0.0 to 1.0)
                  final double letterNormalizedPosition = index / (numLetters - 1);

                  // --- Letter Appearance (Staggered Fade & Scale) ---
                  // Each letter reveals over a specific interval
                  final double revealStart = index * 0.1; // Staggered start
                  final double revealEnd = revealStart + 0.5; // Each letter takes 0.5s to reveal
                  double letterRevealProgress = (_animation.value - revealStart) / (revealEnd - revealStart);
                  letterRevealProgress = letterRevealProgress.clamp(0.0, 1.0); // Clamp to 0-1

                  // Scale effect: letters pop in
                  final double scale = Curves.easeOutBack.transform(letterRevealProgress);
                  final double opacity = Curves.easeInQuad.transform(letterRevealProgress);

                  // --- 3D Folded Effect (Rotation & Size based on position) ---
                  // The "folded" look
                  // Middle letters rotate more and appear smaller, edges less rotation and larger.
                  final double maxRotationAngle = pi / 6; // Max 30 degrees rotation
                  final double maxScaleReduction = 0.2; // Max 20% scale reduction for middle letters

                  // Calculate rotation based on distance from the center of the word
                  // Center of the word is at 0.5 normalized position
                  final double distanceFromCenter = (letterNormalizedPosition - 0.5).abs();
                  final double rotationFactor = Curves.easeInOutSine.transform(distanceFromCenter * 2); // 0 at center, 1 at edges

                  // Rotate Y axis. Letters on the left rotate one way, right the other.
                  final double rotationY = (letterNormalizedPosition < 0.5 ? -1 : 1) *
                      maxRotationAngle * rotationFactor * _perspectiveAnimation.value;

                  // Scale based on distance from center (middle letters smaller)
                  final double centralScaleFactor = 1.0 - (maxScaleReduction * (1.0 - rotationFactor)) * _perspectiveAnimation.value;
                  final double finalLetterScale = scale * centralScaleFactor; // Combine pop-in scale with central scale

                  return Transform(
                    alignment: FractionalOffset.center,
                    transform: Matrix4.identity()
                      ..rotateY(rotationY) // Apply Y-axis rotation for the fold
                      ..scale(finalLetterScale), // Apply dynamic scale
                    child: Opacity(
                      opacity: opacity,
                      child: _buildLetter(letter),
                    ),
                  );
                }),
              ),
            );
          },
        ),
      ),
    );
  }

  // Widget _buildLetter(String letter) {
  //   return Text(
  //     letter,
  //     style: const TextStyle(
  //       fontSize: 80,
  //       fontFamily: 'Maharlika', // Ensure this font is available in your pubspec.yaml
  //       fontWeight: FontWeight.bold,
  //       color: Color.fromARGB(255, 200, 0, 255), // Vibrant purple
  //       letterSpacing: 4,
  //       shadows: [
  //         BoxShadow(
  //           color: Color.fromARGB(255, 128, 0, 128), // Darker purple for outer glow
  //           blurRadius: 25.0,
  //           spreadRadius: 8.0,
  //         ),
  //         BoxShadow(
  //           color: Color.fromARGB(255, 255, 0, 255), // Lighter purple for inner glow
  //           blurRadius: 15.0,
  //           spreadRadius: 5.0,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _buildLetter(String letter) {
    return Text(
      letter,
      style: const TextStyle(
        fontSize: 80,
        fontFamily: 'Maharlika', // Ensure this font is available in your pubspec.yaml
        fontWeight: FontWeight.bold,
        color: Colors.white, // Changed text color to white
        letterSpacing: 4,
        shadows: [
          BoxShadow(
            color: Color.fromARGB(255, 128, 0, 128), // Darker purple for outer glow (can be adjusted if desired)
            blurRadius: 25.0,
            spreadRadius: 8.0,
          ),
          BoxShadow(
            color: Color.fromARGB(255, 255, 0, 255), // Lighter purple for inner glow (can be adjusted if desired)
            blurRadius: 15.0,
            spreadRadius: 5.0,
          ),
        ],
      ),
    );
  }
}