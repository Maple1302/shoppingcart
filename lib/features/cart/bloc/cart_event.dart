import 'package:equatable/equatable.dart';

import '../../../data/models/cart_item.dart';


sealed class CartEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadCart extends CartEvent {}

class AddToCart extends CartEvent {
  final CartItem item;

  AddToCart(this.item);

  @override
  List<Object?> get props => [item];
}
class UpdateToCard extends CartEvent {
  final CartItem item;

  UpdateToCard(this.item);

  @override
  List<Object?> get props => [item];
}
class DecreaseQuantity extends CartEvent {

  final CartItem item;

  DecreaseQuantity(this.item);

  @override
  List<Object?> get props => [item];
}

class RemoveFromCart extends CartEvent {
  final int productId;

  RemoveFromCart(this.productId);

  @override
  List<Object?> get props => [productId];
}

class ClearCart extends CartEvent {}
