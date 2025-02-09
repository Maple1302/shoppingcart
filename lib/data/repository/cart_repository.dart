import '../local/cart_dao.dart';
import '../models/cart_item.dart';

class CartRepository {
  final CartDAO _cartDAO = CartDAO();

  Future<void> addToCart(CartItem item) => _cartDAO.addToCart(item);

  Future<List<CartItem>> getCartItems() => _cartDAO.getCartItems();

  Future<int> getTotalQuantity() => _cartDAO.getTotalQuantity();

  Future<double> getTotalPrice() => _cartDAO.getTotalPrice();

  Future<void> updateCartItem(CartItem item) => _cartDAO.updateCartItem(item);

  Future<void> decreaseQuantity(CartItem item) => _cartDAO.decreaseQuantity(item);

  Future<void> removeFromCart(int productId) => _cartDAO.removeFromCart(productId);

  Future<void> clearCart() => _cartDAO.clearCart();
}
