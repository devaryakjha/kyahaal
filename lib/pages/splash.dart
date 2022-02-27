import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kyahaal/controllers/index.dart';
import 'package:kyahaal/utils/constants.dart';
import 'package:kyahaal/widgets/applogo.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  final logoState = {
    'top': 0.0,
    'left': 0.0,
    'right': 0.0,
    'bottom': 0.0,
    'size': MediaQuery.of(Get.context!).size.width * 0.5,
    'opacity': 0.0,
  };

  void _handleTimerComplete() {
    setState(() {
      logoState['top'] = -150.0;
    });
    Timer(const Duration(milliseconds: 500), () {
      setState(() {
        logoState['opacity'] = 0.6;
      });
      Timer(
        Duration(milliseconds: kAnimationDurationLong.inMilliseconds + 500),
        AuthController.to.startAuthCheck,
      );
    });
  }

  @override
  void initState() {
    Timer(const Duration(seconds: 1), _handleTimerComplete);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: logoState['left']!,
            right: logoState['right']!,
            bottom: size.center(Offset.zero).dy - 100,
            child: AnimatedOpacity(
              curve: Curves.fastOutSlowIn,
              opacity: logoState['opacity']!,
              duration: kAnimationDurationLong,
              child: const Text(
                'KyaHaal',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 48.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          Positioned(
            left: logoState['left']!,
            right: logoState['right']!,
            bottom: size.center(Offset.zero).dy - 250,
            child: Center(
              child: Obx(
                () => NetworkController.to.isConnected
                    ? AuthController.to.isLoading
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink()
                    : TextButton(
                        child: const Text('Retry'),
                        onPressed: () {},
                      ),
              ),
            ),
          ),
          AnimatedPositioned(
            curve: Curves.fastOutSlowIn,
            left: logoState['left']!,
            right: logoState['right']!,
            top: logoState['top']!,
            bottom: logoState['bottom']!,
            duration: kAnimationDurationLong,
            child: const Center(
              child: AppLogo(
                size: 120.0,
                duration: kAnimationDuration,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
