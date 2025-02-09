import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/config/utils/money_helper.dart';
import 'package:shoppingcart/config/utils/screen_helper.dart';
import 'package:shoppingcart/data/models/cart_item.dart';
import 'package:shoppingcart/features/cart/view/widgets/change_quantity_form.dart';
import '../../../../core/color.dart';
import '../../bloc/cart_bloc.dart';
import '../../bloc/cart_event.dart';

class CartCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback? closeAction;
  final VoidCallback? increaseQuantityAction;
  final VoidCallback? decreaseQuantityAction;
  final VoidCallback? onSubmit;
  final bool isCart;
  final TextEditingController quantityController;


  const CartCard(
      {super.key,
      required this.item,
      required this.closeAction,
      this.increaseQuantityAction,
      this.decreaseQuantityAction, required this.quantityController,  required this.isCart, this.onSubmit});

  @override
  Widget build(BuildContext context) {
    final widthScreen = ScreenHelper.screenWidth(context);
    final heightItem = ScreenHelper.screenHeight(context) / 6;
    return Row(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            width: widthScreen / 5,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                image: DecorationImage(
                    image: AssetImage(item.product.image), fit: BoxFit.fill)),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.product.name,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    GestureDetector(
                      onTap: () {
                        closeAction!();
                      },
                      child: Container(
                        width: widthScreen / 12,
                        height: widthScreen / 12,
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black12),
                            borderRadius: BorderRadius.circular(8)),
                        child: Icon(Icons.close),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: widthScreen / 3,
                          height: widthScreen / 12,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              border:
                                  Border.all(color: Colors.black12, width: 2)),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      decreaseQuantityAction!();
                                    },
                                    child: Icon(Icons.remove)),
                              ),
                              Expanded(
                                flex: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    showChangeQuantityDialog(
                                        context, quantityController, item, isCart?() {
                                      final updateItem = CartItem(
                                          product: item.product,
                                          quantity: int.parse(
                                              quantityController.text));
                                      context
                                          .read<CartBloc>()
                                          .add(UpdateToCard(updateItem));
                                      Navigator.pop(context);
                                    }:(){
                                          onSubmit!();
                                 });
                                  },
                                  child: Container(
                                    height: double.infinity,
                                    decoration: const BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.black12, width: 2),
                                          left: BorderSide(
                                              color: Colors.black12, width: 2)),
                                    ),
                                    child: Center(
                                      child: Text(
                                        item.quantity.toString(),
                                        textAlign: TextAlign.center,
                                        // style: TextStyle(fontSize: 21),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      increaseQuantityAction!();
                                    },
                                    child: const Icon(Icons.add)),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          MoneyHelper.formatToVND(
                            item.product.price,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: ColorManager.orange,
                            fontWeight: FontWeight.w600,
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  void showChangeQuantityDialog(BuildContext context,
      TextEditingController controller, CartItem item, VoidCallback onSubmit) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ChangeQuantityForm(
          item: item,
          onSubmit: () {
            onSubmit();
          },
          quantityController: controller,
        );
      },
    );
  }
}
