import 'dart:convert';

import 'package:e_commerce_app/models/rating.dart';

class Product {
  String? shopId;
  final String name;
  final String description;
  final double quantity;
  final List<String> images;

  final String category;
  final String shopName;
  final double price;

  final String? id;
  final List<Rating>? rating;

  Product(
      {this.shopId,
      required this.name,
      required this.description,
      required this.quantity,
      required this.images,
      required this.category,
      required this.shopName,
      required this.price,
      this.id,
      this.rating});

  Map<String, dynamic> toMap() {
    return {
      'shopId': shopId,
      'name': name,
      'description': description,
      'quantity': quantity,
      'images': images,
      'category': category,
      'shopName': shopName,
      'price': price,
      'id': id,
      'rating': rating,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
        shopId: map['shopId'] ?? '',
        name: map['name'] ?? '',
        description: map['description'] ?? '',
        quantity: map['quantity']?.toDouble() ?? 0.0,
        images: List<String>.from(map['images']),
        category: map['category'] ?? '',
        shopName: map['shopName'] ?? '',
        price: map['price']?.toDouble() ?? 0.0,
        id: map['_id'],
        rating: map['ratings'] != null
            ? List<Rating>.from(
                map['ratings']?.map(
                  (x) => Rating.fromMap(x),
                ),
              )
            : null);
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source));
}
