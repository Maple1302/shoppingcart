import 'package:sqflite/sqflite.dart';
import '../models/product.dart';
import 'database_helper.dart';

class ProductDao {
  ProductDao();
  Future<void> insertProduct(Product product) async {
    final db = await DatabaseHelper().database;
    await db.insert(
      'products',
      product.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Product>> getProductHot() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query(
      'products',
      where: 'isHot = ?',
      whereArgs: [1],
    );

    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }
  Future<List<Product>> getListProduct() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('products');
    print(maps);
    return List.generate(maps.length, (i) => Product.fromMap(maps[i]));
  }
}
