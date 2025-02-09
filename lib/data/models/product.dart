import 'package:equatable/equatable.dart';

class Product extends Equatable {
  final int id;
  final String name;
  final String image;
  final double price;
  final bool isHot;

  const Product(
      {this.id = 0,
      this.name = "",
      this.image = "",
      this.price = 0,
      this.isHot = false});

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      price: map['price'].toDouble(),
      isHot: map['isHot'] == null ? false:map['isHot'] == 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'price': price,
      'isHot': isHot ? 1 : 0,
    };
  }

  @override
  List<Object> get props => [id, name, image, price, isHot];
}
