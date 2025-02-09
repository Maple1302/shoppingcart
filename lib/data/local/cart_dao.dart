import '../models/cart_item.dart';
import 'database_helper.dart';

class CartDAO {
  Future<int> addToCart(CartItem item) async {
    final db = await DatabaseHelper().database;

    final existing = await db.query(
      'cart',
      where: 'product_id = ?',
      whereArgs: [item.product.id],
    );

    if (existing.isNotEmpty) {
      int newQuantity =
          item.quantity + (existing.first['quantity'] as num).toInt();
      return await db.update(
        'cart',
        {'quantity': newQuantity},
        where: 'product_id = ?',
        whereArgs: [item.product.id],
      );
    } else {
      return await db.insert('cart', item.toMap());
    }
  }

  Future<List<CartItem>> getCartItems() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> cartData = await db.rawQuery('''
      SELECT p.id, p.name,p.image, p.price, c.quantity 
      FROM cart c
      JOIN products p ON p.id = c.product_id
    ''');

    return cartData.map((data) => CartItem.fromMap(data)).toList();
  }

  Future<int> getTotalQuantity() async {
    final db = await DatabaseHelper().database;
    final result = await db.rawQuery('SELECT SUM(quantity) as total FROM cart');
    return result.first['total'] != null ? result.first['total'] as int : 0;
  }

  Future<double> getTotalPrice() async {
    final db = await DatabaseHelper().database;
    final result = await db.rawQuery(
        "SELECT SUM(products.price * cart.quantity) as total FROM cart JOIN products ON cart.product_id = products.id");

    return result.first["total"] != null
        ? (result.first["total"] as num).toDouble()
        : 0.0;
  }

  Future<int> updateCartItem(CartItem item) async {
    final db = await DatabaseHelper().database;
    return await db.update(
      'cart',
      {'quantity': item.quantity},
      where: 'product_id = ?',
      whereArgs: [item.product.id],
    );
  }

  Future<void> decreaseQuantity(CartItem item) async {
    final db = await DatabaseHelper().database;
    final result = await db.query(
      'cart',
      columns: ['quantity'],
      where: 'product_id = ?',
      whereArgs: [item.product.id],
    );

    if (result.isNotEmpty) {
      int currentQuantity = result.first['quantity'] as int;

      if (currentQuantity > 1) {
        // Nếu số lượng > 1, giảm đi 1
        await db.update(
          'cart',
          {'quantity': currentQuantity - 1},
          where: 'product_id = ?',
          whereArgs: [item.product.id],
        );
      } else {
        // Nếu số lượng = 1, xóa sản phẩm khỏi giỏ hàng
        await db.delete(
          'cart',
          where: 'product_id = ?',
          whereArgs: [item.product.id],
        );
      }
    }
  }

  Future<int> removeFromCart(int productId) async {
    final db = await DatabaseHelper().database;
    return await db.delete(
      'cart',
      where: 'product_id = ?',
      whereArgs: [productId],
    );
  }

  Future<void> clearCart() async {
    final db = await DatabaseHelper().database;
    await db.delete('cart');
  }
}
