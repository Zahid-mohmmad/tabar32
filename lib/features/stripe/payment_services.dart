import 'package:dio/dio.dart';
import 'package:e_commerce_app/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

class PaymentServices {
  PaymentServices._();

  static final PaymentServices instance = PaymentServices._();

  Future<void> makePayment(BuildContext context) async {
    try {} catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
