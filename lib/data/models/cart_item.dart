import 'package:equatable/equatable.dart';
import 'product.dart';

class CartItem extends Equatable {
  final Product product;
  final int quantity;

  const CartItem({
    required this.product,
    required this.quantity,
  });

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      product: Product.fromMap(map),
      quantity: map['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'product_id':product.id ,
      'quantity': quantity,
    };
  }

  @override
  List<Object?> get props => [product, quantity];
}
