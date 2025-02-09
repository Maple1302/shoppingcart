import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/config/utils/screen_helper.dart';
import 'package:shoppingcart/data/models/cart_item.dart';
import 'package:shoppingcart/features/cart/bloc/cart_event.dart';
import 'package:shoppingcart/features/cart/view/widgets/cart_card.dart';

import '../../../../core/color.dart';
import '../../../../core/text_style.dart';
import '../../../../data/models/product.dart';
import '../../../cart/bloc/cart_bloc.dart';

class HomeBottomSheet extends StatefulWidget {
  final Product item;

  const HomeBottomSheet({super.key, required this.item});

  @override
  State<HomeBottomSheet> createState() => _HomeBottomSheetState();
}

class _HomeBottomSheetState extends State<HomeBottomSheet> {
  int quantity = 1;
  TextEditingController quantityController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    quantityController.text = "1";
  }

  @override
  Widget build(BuildContext context) {
    final heightItem = ScreenHelper.screenHeight(context) / 4;
    final heightProduct = ScreenHelper.screenHeight(context) / 8;
    final widthScreen = ScreenHelper.screenWidth(context);

    return Container(
      height: heightItem,
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10), topRight: Radius.circular(10))),
      child: Padding(
        padding: ScreenHelper.screenEdgeInsets(context),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: ScreenHelper.screenEdgeInsets(context)
                  .copyWith(left: 0, right: 0),
              width: widthScreen,
              height: heightProduct,
              child: CartCard(
                isCart: false,
                onSubmit: () {
                  setState(() {
                    quantity = int.parse(quantityController.text);
                    Navigator.pop(context);
                  });
                },
                item: CartItem(product: widget.item, quantity: quantity),
                closeAction: () {
                  Navigator.pop(context);
                },
                decreaseQuantityAction: () {
                  setState(() {
                    quantity -= 1;
                  });
                },
                increaseQuantityAction: () {
                  quantity += 1;
                },
                quantityController: quantityController,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddToCart(
                      CartItem(product: widget.item, quantity: quantity)));
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorManager.yellow,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bo góc 20
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    "Add to Cart",
                    style: AppTextStyle.buttonTextStyle.copyWith(fontSize: 20),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
