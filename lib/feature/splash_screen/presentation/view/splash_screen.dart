import 'package:animevn/feature/splash_screen/presentation/widget/circle_path_animation.dart';
import 'package:flutter/material.dart';
import 'package:animevn/feature/home/presentation/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CirclePathAnimation(directionPage: HomeScreen(),),
      ),
    );
  }
}