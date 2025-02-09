import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/repository/cart_repository.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  final CartRepository _cartRepository;

  CartBloc({CartRepository? cartRepository})
      : _cartRepository = CartRepository(),
        super(const CartState()) {
    on<LoadCart>(_onLoadCart);
    on<AddToCart>(_onAddToCart);
    on<DecreaseQuantity>(_onDecreaseQuantity);
    on<UpdateToCard>(_onUpdateToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
  }

  Future<void> _onLoadCart(LoadCart event, Emitter<CartState> emit) async {
    try {
      emit(const CartState(isCartLoading: true, error: null));
      final items = await _cartRepository.getCartItems();
      final totalQuantityCart = await _cartRepository.getTotalQuantity();
      final totalPrice = await _cartRepository.getTotalPrice();
      emit(CartState(
          isCartLoading: false,
          items: items,
          totalQuantity: totalQuantityCart,
          totalAmount: totalPrice));
    } catch (e) {
      emit(CartState(error: e.toString()));
    }
  }

  Future<void> _onAddToCart(AddToCart event, Emitter<CartState> emit) async {
    try {
      await _cartRepository.addToCart(event.item);
      add(LoadCart()); // Reload cart
    } catch (e) {
      emit(CartState(error: e.toString()));
    }
  }

  Future<void> _onDecreaseQuantity(DecreaseQuantity event, Emitter<CartState> emit) async {
    try {
      await _cartRepository.decreaseQuantity(event.item);
      add(LoadCart()); // Reload cart
    } catch (e) {
      emit(CartState(error: e.toString()));
    }
  }
  Future<void> _onUpdateToCart(UpdateToCard event, Emitter<CartState> emit) async {
    try {
      await _cartRepository.updateCartItem(event.item);
      add(LoadCart()); // Reload cart
    } catch (e) {
      emit(CartState(error: e.toString()));
    }
  }

  Future<void> _onRemoveFromCart(
      RemoveFromCart event, Emitter<CartState> emit) async {
    try {
      await _cartRepository.removeFromCart(event.productId);
      add(LoadCart()); // Reload cart
    } catch (e) {
      emit(CartState(error: e.toString()));
    }
  }

  Future<void> _onClearCart(ClearCart event, Emitter<CartState> emit) async {
    try {
      await _cartRepository.clearCart();
      emit(const CartState()); // Empty cart
    } catch (e) {
      emit(CartState(error: e.toString()));
    }
  }
}
