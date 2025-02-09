import 'package:go_router/go_router.dart';
import 'package:shoppingcart/config/router/route_names.dart';

import '../../features/cart/view/cart_screen.dart';
import '../../features/home/view/home_screen.dart';
import '../../features/splash/view/splash_screen.dart';

final appRouter = GoRouter(
  initialLocation: RouteNames.splash,
  routes: [
    GoRoute(
      path: RouteNames.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: RouteNames.home,
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: RouteNames.cart,
      builder: (context, state) => const CartScreen(),
    ),
  ],
);