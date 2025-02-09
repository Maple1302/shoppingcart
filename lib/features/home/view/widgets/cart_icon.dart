import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingcart/core/color.dart';
import 'package:shoppingcart/features/cart/bloc/cart_bloc.dart';
import 'package:shoppingcart/features/cart/bloc/cart_state.dart';

import '../../../../config/router/route_names.dart';
import '../../../../config/utils/screen_helper.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key});

  // @override
  // Widget build(BuildContext context) {
  //   return BlocBuilder<CartBloc, CartState>(
  //     builder: (context, state) {
  //       return Stack(
  //         children: [
  //           IconButton(
  //             icon: const Icon(Icons.shopping_cart),
  //             onPressed: () {
  //               Navigator.push(
  //                 context,
  //                 MaterialPageRoute(builder: (context) => CartScreen()),
  //               );
  //             },
  //           ),
  //           if (state is CartUpdated && state.cartItems.isNotEmpty)
  //             Positioned(
  //               right: 8,
  //               top: 8,
  //               child: CircleAvatar(
  //                 radius: 10,
  //                 backgroundColor: Colors.red,
  //                 child: Text(
  //                   state.cartItems.length.toString(),
  //                   style: TextStyle(color: Colors.white, fontSize: 12),
  //                 ),
  //               ),
  //             ),
  //         ],
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    final size = ScreenHelper.screenSize(context);
    final iconSize =
        ScreenHelper.isPhone(context) ? size.width * 0.07 : size.width * 0.05;
    final totalCartSize =
        ScreenHelper.isPhone(context) ? size.width * 0.053 : size.width * 0.033;
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return Stack(children: [
        IconButton(
          iconSize: iconSize,
          icon: const Icon(
            Icons.shopping_cart_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            context.go(RouteNames.cart);
          },
        ),
        Positioned(
            width: totalCartSize,
            height: totalCartSize,
            left: 1,
            bottom: 8,
            child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: ColorManager.orange,
                  border: Border.all(color: Colors.white),
                  shape: BoxShape.circle),
              child: Text(
                state.totalQuantity.toString(),
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ))
      ]);
    });
  }
}
