import 'dart:math';
import 'package:animevn/core/constant/app_color.dart';
import 'package:animevn/feature/home/presentation/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CirclePathAnimation extends StatefulWidget {
  const CirclePathAnimation({super.key, this.directionPage, this.actionAfterComplete});


  final Widget? directionPage;
  final Function? actionAfterComplete;


  @override
  State<CirclePathAnimation> createState() => _CirclePathAnimationState();
}

class _CirclePathAnimationState extends State<CirclePathAnimation>
    with TickerProviderStateMixin {
  late AnimationController _moveController;
  late AnimationController _gatherController;
  late AnimationController _revealController;
  late CurvedAnimation _curvedReveal;
  late CurvedAnimation _curvedGather;

  bool isStart = false;
  static const int maxDots = 5;
  int currentDots = 1;

  static const double baseRadius = 60;
  static const double dotSize = 20;

  bool isGathering = false;

  @override
  void initState() {
    super.initState();
    run();
  }


  void run() {
    if(isStart && mounted){
      _moveController.dispose();
      _gatherController.dispose();
      _revealController.dispose();
    }

    // Reset biến trạng thái
    setState(() {
      currentDots = 1;
      isGathering = false;
    });

    // Khởi tạo lại controller mới
    _moveController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _gatherController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _revealController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _curvedReveal = CurvedAnimation(
      parent: _revealController,
      curve: Curves.easeOutBack,
    );

    _curvedGather = CurvedAnimation(
      parent: _gatherController,
      curve: Curves.easeInOutCubic,
    );

    // Khi quay đủ 1 vòng thì thêm dot
    _moveController.addStatusListener((status) async {
      if (status == AnimationStatus.completed) {
        _moveController.reset();

        if (currentDots < maxDots) {
          setState(() {
            currentDots++;
          });
          _moveController.forward();
        } else {
          isGathering = true;
          _gatherController.forward();
        }
      }
    });

    // Khi gom gần xong, bắt đầu phase reveal sớm
    _gatherController.addListener(() {
      if (_gatherController.value > 0.7 &&
          !_revealController.isAnimating &&
          !_revealController.isCompleted) {
        _revealController.forward();
      }
    });

    _curvedReveal.addListener(() async {
      if(_curvedReveal.isCompleted){

        await widget.actionAfterComplete?.call();
        if (widget.directionPage != null) _navigate();

      }
    });

    // Bắt đầu animation
    _moveController.forward();
  }



  @override
  void dispose() {
    _moveController.dispose();
    _gatherController.dispose();
    _revealController.dispose();
    super.dispose();
  }

  void _navigate() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const HomeScreen()),
    );

  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _moveController,
        _gatherController,
        _revealController,
      ]),
      builder: (context, _) {
        final double progress = _moveController.value * 2 * pi;
        final double gatherValue = 1 - _curvedGather.value;
        final double revealScale =
        Tween(begin: 0.0, end: 1.0).transform(_curvedReveal.value);
        final double dotsOpacity =
        (1 - _curvedGather.value).clamp(0.0, 1.0); // fade dần dot

        List<Widget> dots = [];
        for (int i = 0; i < currentDots; i++) {
          final angle = progress + (i * 2 * pi / currentDots);
          final double x = baseRadius * gatherValue * cos(angle);
          final double y = baseRadius * gatherValue * sin(angle);

          dots.add(Transform.translate(
            offset: Offset(x, y),
            child: Opacity(
              opacity: dotsOpacity,
              child: Container(
                width: dotSize,
                height: dotSize,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.primaries[i % Colors.primaries.length],
                ),
              ),
            ),
          ));
        }

        return Center(
          child: Stack(
            alignment: Alignment.center,
            children: [
              ...dots,
              Transform.scale(
                scale: revealScale,
                child: Opacity(
                  opacity: _curvedReveal.value.clamp(0.0, 1.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: 'splash',
                        child: SvgPicture.asset(
                          'assets/logo.svg',
                          height: 350,
                          width: 350,
                          fit: BoxFit.contain,
                        ),
                      ),
                      const Text(
                        'Anime VN',
                        style: TextStyle(
                          color: AppColors.blueColor,
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
