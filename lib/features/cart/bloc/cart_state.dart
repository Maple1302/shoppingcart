import 'package:equatable/equatable.dart';

import '../../../data/models/cart_item.dart';

class CartState extends Equatable {
  @override
  List<Object?> get props => [items, isCartLoading, totalQuantity, error];
  final List<CartItem> items;
  final bool isCartLoading;
  final int totalQuantity;
  final double totalAmount;
  final String? error;

  const CartState(
      {this.items = const [],
      this.isCartLoading = false,
      this.totalQuantity = 0,
      this.totalAmount = 0,
      this.error});

  CartState copyWith(List<CartItem>? items, bool? isCartLoading,
      int? totalQuantity, double? totalAmount, String? error) {
    return CartState(
        items: items ?? this.items,
        isCartLoading: isCartLoading ?? this.isCartLoading,
        totalQuantity: totalQuantity ?? this.totalQuantity,
        totalAmount: totalAmount ?? this.totalAmount,
        error: error ?? this.error);
  }
}

