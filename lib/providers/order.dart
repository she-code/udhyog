import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udhyog/screens/orderDetails.dart';

import '../config/config.dart';
import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  //get the input and send it
  List<Order> _orders = [];
  // String? _orderId;
  // String get orderId {
  //   return _orderId!;
  // }

  //create order
  Future<void> createOrder(
      int amount, String authToken, BuildContext context) async {
    //send the amount

    try {
      final url = Uri.parse('${AppConstants.baseURl}/orders/createOrder');
      final response = await http.post(url,
          body: json.encode({
            "amount": amount,
          }),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": authToken
          });
      final responseData = json.decode(response.body);
      final order = responseData['order'];

      if (responseData != null) {
        final newOrder = Order(
            order_id: order['order_id'],
            amount: order['amount'],
            status: order['status'],
            company_id: order['company_id']);
        Navigator.of(context).pushReplacementNamed(OrderDetails.routeName,
            arguments: [newOrder.order_id, newOrder.amount]);

        print(newOrder.order_id);
      }
      // print(responseData);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<bool> verifyOrder(String orderId, String raz_payId,
      String raz_signiture, String authToken, BuildContext context) async {
    //send the amount

    try {
      final url = Uri.parse('${AppConstants.baseURl}/orders/verifyOrder');
      final response = await http.post(url,
          body: json.encode({
            // "amount": amount,
            "raz_payId": raz_payId,
            "raz_signiture": raz_payId,
            "orderId": raz_payId
          }),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": authToken
          });
      final responseData = json.decode(response.body);

      if (responseData != null) {
        // Navigator.of(context).pushReplacementNamed(OrderDetails.routeName,
        //     arguments: [newOrder.order_id, newOrder.amount]);

        print(responseData);
      }
      // print(responseData);
      notifyListeners();
      return true;
    } catch (e) {
      throw e;
    }
  }
}
