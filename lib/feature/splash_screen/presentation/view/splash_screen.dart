import 'dart:async';
import 'package:flutter/material.dart';

import '../../../../core/constant/const.dart';
import '../../../home/presentation/view/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: SizedBox(
              height: 500,
              width: 600,
              child: Image.asset(
                'assets/Logo.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          Text(
            '$currentYear. Anime 4ever . All rights reversed.',
            style: styleTileItem,
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
