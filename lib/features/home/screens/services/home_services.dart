import 'dart:convert';

import 'package:e_commerce_app/constants/error_handling.dart';
import 'package:e_commerce_app/constants/global_variables.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:e_commerce_app/models/product.dart';
import 'package:e_commerce_app/providers/user_provider.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

class HomeServices {
  final FirebaseDatabase database = FirebaseDatabase.instance;
  Future<List<Product>> fetchShopProducts(
      {required BuildContext context, required String shop}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/products?shopName=$shop'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'x-auth-token': userProvider.user.token,
      });

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
          }
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }

  Future<List<Product>> fetchShopProductsfirebase({
    required BuildContext context,
    required String shop,
  }) async {
    List<Product> productList = [];
    try {
      DatabaseEvent event = await database.ref('products').once();
      DataSnapshot snapshot = event.snapshot;

      Map<dynamic, dynamic>? values = snapshot.value as Map<dynamic, dynamic>?;

      if (values != null) {
        values.forEach((key, value) {
          Map<String, dynamic> productMap = Map<String, dynamic>.from(value);
          // Check if the product belongs to the specified shop
          if (productMap['shop'] == shop) {
            print(productMap);
            productList.add(Product.fromMap(productMap));
          }
        });
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
    return productList;
  }
}
