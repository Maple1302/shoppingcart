import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingcart/config/router/app_router.dart';
import 'package:shoppingcart/config/utils/money_helper.dart';
import 'package:shoppingcart/config/utils/screen_helper.dart';
import 'package:shoppingcart/core/color.dart';
import 'package:shoppingcart/features/cart/bloc/cart_event.dart';
import 'package:shoppingcart/features/cart/bloc/cart_state.dart';

import '../../../../config/router/route_names.dart';
import '../../../../core/text_style.dart';
import '../../bloc/cart_bloc.dart';

class CartBottomSheet extends StatelessWidget {
  const CartBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final heightScreen = ScreenHelper.screenHeight(context) / 6;
    final widthScreen = ScreenHelper.screenWidth(context);
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return state.totalQuantity > 0
          ? Container(
              padding: ScreenHelper.screenEdgeInsets(context) * 2,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.zero,
                  border: Border.all(color: Colors.black12)),
              height: heightScreen,
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "TotalPrice",
                        style: AppTextStyle.productNameTextStyle
                            .copyWith(fontSize: 18),
                      ),
                      Text(
                        MoneyHelper.formatToVND(state.totalAmount),
                        style: AppTextStyle.productNameTextStyle
                            .copyWith(fontSize: 18),
                      )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<CartBloc>().add(
                            ClearCart(),
                          );
                      showOrderSuccessDialog(context);
                    },
                    child: Container(
                        alignment: Alignment.center,
                        height: heightScreen / 3,
                        width: double.infinity,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorManager.yellow),
                        child: const Text(
                          "Order",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )),
                  )
                ],
              ),
            )
          : Container();
    });
  }

  void showOrderSuccessDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "Order Successfully!",
            textAlign: TextAlign.center,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          actionsAlignment: MainAxisAlignment.center,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          actions: [
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bo góc 20
                  ),
                ),
                onPressed: () {
                  context.go(RouteNames.home); // Đóng dialog
                },
                child: Text(
                  "Back to Home",
                  style: AppTextStyle.buttonTextStyle,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
