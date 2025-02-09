import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingcart/config/utils/screen_helper.dart';
import '../../../config/router/route_names.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  Future<void> navigateToHome() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      context.go(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = ScreenHelper.screenSize(context);
    final year = DateTime.now().year;
    final imageSie = ScreenHelper.isPhone(context) ? size.width * 0.25 : size.width * 0.2;

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              'assets/images/cart.png',
              width: imageSie,
              height: imageSie,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 32,
            child: Text(
              '© $year, QSoft. All rights reserved.',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}