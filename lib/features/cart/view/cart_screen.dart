import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:shoppingcart/config/router/route_names.dart';
import 'package:shoppingcart/features/cart/view/widgets/bottom_sheet.dart';
import 'package:shoppingcart/features/cart/view/widgets/cart_card.dart';
import '../../../config/utils/screen_helper.dart';
import '../../../core/color.dart';
import '../../../data/models/cart_item.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final widthScreen = ScreenHelper.screenWidth(context);
    final heightItem = ScreenHelper.screenHeight(context) / 6;
    return Scaffold(
      appBar: AppBar(
        title: const TitleCart(),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              context.go(RouteNames.home);
            },
            icon: const Icon(Icons.arrow_back, color: Colors.white)),
        backgroundColor: ColorManager.orange,
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.isCartLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (!state.isCartLoading) {
            final cartItems = state.items;
            return ListView.builder(
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final item = cartItems[index];
                return Container(
                    width: widthScreen - 30,
                    height: heightItem,
                    margin: EdgeInsets.all(8),
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.white,
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: CartCard(
                      item: item,
                      quantityController: TextEditingController(),
                      closeAction: () {
                        context
                            .read<CartBloc>()
                            .add(RemoveFromCart(item.product.id));
                      },
                      decreaseQuantityAction: () {
                        context.read<CartBloc>().add(
                              DecreaseQuantity(
                                  CartItem(product: item.product, quantity: 1)),
                            );
                      },
                      increaseQuantityAction: () {
                        context.read<CartBloc>().add(AddToCart(
                            CartItem(product: item.product, quantity: 1)));
                      },
                      isCart: true,
                    ));
              },
            );
          } else if (state.error != null) {
            return Center(child: Text(state.error ?? ""));
          }
          return Container();
        },
      ),
      bottomSheet: const CartBottomSheet(),
    );
  }
}

class TitleCart extends StatelessWidget {
  const TitleCart({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(builder: (context, state) {
      return Text(
        "Cart (${state.totalQuantity})",
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
      );
    });
  }
}
