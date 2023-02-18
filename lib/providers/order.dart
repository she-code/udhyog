import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:udhyog/screens/orderDetails.dart';

import '../models/order.dart';

class OrderProvider with ChangeNotifier {
  //get the input and send it
  List<Order> _orders = [];

  //create order
  Future<void> createOrder(
      int amount, String authToken, BuildContext context) async {
    //send the amount

    try {
      final url =
          Uri.parse('http://192.168.254.16:5001/api/orders/createOrder');
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
      // if (responseData) {
      //   Navigator.of(context).pushReplacementNamed(OrderDetails.routeName);
      // }
      print(responseData);
      notifyListeners();
    } catch (e) {}
  }
}
