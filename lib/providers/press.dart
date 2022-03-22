import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/press.dart';

class PressProvider with ChangeNotifier {
  List<Press> _presses = [
    Press(
      pressId: 1,
      partCount: 1.2,
      pressName: 'Press 1',
      blockTemp: '23',
      clientId: 1,
      createdAt: DateTime.now(),
      hoseTemp: 24,
      pressType: 'automatic',
      tankLowerTemp: 24,
      tankTopTemp: 25,
      timer: 123,
    ),
    Press(
      pressId: 1,
      partCount: 1.2,
      pressName: 'Press 2',
      blockTemp: '23',
      clientId: 1,
      createdAt: DateTime.now(),
      hoseTemp: 24,
      pressType: 'automatic',
      tankLowerTemp: 24,
      tankTopTemp: 25,
      timer: 123,
    ),
    Press(
      pressId: 1,
      partCount: 1.2,
      pressName: 'Press 2',
      blockTemp: '23',
      clientId: 1,
      createdAt: DateTime.now(),
      hoseTemp: 24,
      pressType: 'automatic',
      tankLowerTemp: 24,
      tankTopTemp: 25,
      timer: 123,
    ),
  ];
  final String authToken;
  PressProvider(this.authToken, this._presses);
  List<Press> get presses {
    return [..._presses];
  }

  int get pressLength {
    return _presses.length;
  }

  void addPress(Press press) {
    final newPress = Press(
        pressId: press.pressId,
        pressType: press.pressType,
        pressName: press.pressName,
        clientId: press.clientId,
        createdAt: press.createdAt,
        tankTopTemp: press.tankTopTemp,
        tankLowerTemp: press.tankLowerTemp,
        blockTemp: press.blockTemp,
        hoseTemp: press.hoseTemp,
        partCount: press.partCount,
        timer: press.timer);
    _presses.add(newPress);
  }

  Future<void> addPressDb(String pressType, String authTok) async {
    final url = Uri.parse('http://localhost:5001/auth/presses');
    try {
      final response = await http
          .post(url, body: json.encode({"TypeOfPress": pressType}), headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": authTok
      });
      notifyListeners();
      final responseData = json.decode(response.body);
      //print({"authToken", authToken});
    } catch (e) {
      throw e;
    }
  }
}
// Press(
    //   pressId: 1,
    //   partCount: 1.2,
    //   pressName: 'Press 1',
    //   blockTemp: '23',
    //   clientId: 1,
    //   createdAt: DateTime.now(),
    //   hoseTemp: 24,
    //   pressType: 'automatic',
    //   tankLowerTemp: 24,
    //   tankTopTemp: 25,
    //   timer: 123,
    // ),
    // Press(
    //   pressId: 1,
    //   partCount: 1.2,
    //   pressName: 'Press 2',
    //   blockTemp: '23',
    //   clientId: 1,
    //   createdAt: DateTime.now(),
    //   hoseTemp: 24,
    //   pressType: 'automatic',
    //   tankLowerTemp: 24,
    //   tankTopTemp: 25,
    //   timer: 123,
    // ),
    // Press(
    //   pressId: 1,
    //   partCount: 1.2,
    //   pressName: 'Press 2',
    //   blockTemp: '23',
    //   clientId: 1,
    //   createdAt: DateTime.now(),
    //   hoseTemp: 24,
    //   pressType: 'automatic',
    //   tankLowerTemp: 24,
    //   tankTopTemp: 25,
    //   timer: 123,
    // ),