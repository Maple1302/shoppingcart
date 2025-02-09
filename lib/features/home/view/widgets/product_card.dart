import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/config/utils/money_helper.dart';
import 'package:shoppingcart/core/color.dart';
import 'package:shoppingcart/core/text_style.dart';
import 'package:shoppingcart/features/home/view/widgets/home_bottom_sheet.dart';

import '../../../../data/models/cart_item.dart';
import '../../../../data/models/product.dart';
import '../../../cart/bloc/cart_bloc.dart';
import '../../../cart/bloc/cart_event.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  final bool isHot;

  const ProductCard({
    super.key,
    required this.product,
    this.isHot = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: [
          Stack(
            children: [
              Image(
                image: AssetImage(product.image),
                fit: BoxFit.cover,
              ),
              if (isHot)
                Positioned(
                  top: 8.0,
                  left: 8.0,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Text('🔥'),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(product.name,
                          style: AppTextStyle.productNameTextStyle),
                      Text(MoneyHelper.formatToVND(product.price),
                          style: AppTextStyle.productPriceTextStyle),
                    ],
                  ),
                  Flexible(
                    child: IconButton(
                      icon: const Icon(
                        Icons.add_shopping_cart,
                        color: ColorManager.orange,
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return HomeBottomSheet(item: product);
                            });
                        // context.read<CartBloc>().add(
                        //       AddToCart(
                        //           CartItem(product: product, quantity: 1)),
                        //     );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
