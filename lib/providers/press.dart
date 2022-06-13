import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/press.dart';

class PressProvider with ChangeNotifier {
  late String _authToken;

  void authToken(String value) {
    _authToken = value;
  }

  Press findByID(String id) {
    return _presses.firstWhere((prod) => prod.press_id == id);
  }

  PressProvider(this._authToken, this._presses);

  List<Press> _presses = [];

  List<Press> get presses {
    return [..._presses];
  }

  int get pressLength {
    return _presses.length;
  }

  Future<void> addPressDb(
    String location,
    String static_id,
    String hotsPassword,
    String hotspot,
    String frequency,
    String TypeOfPress,
    //String authTok
  ) async {
    final url = Uri.parse('http://localhost:5001/press');
    try {
      // print(_pressData);
      print(_authToken);
      final response = await http.post(url,
          body: json.encode({
            "TypeOfPress": TypeOfPress,
            "hots_password": hotsPassword,
            "hotspot": hotspot,
            "frequency": frequency,
            "location": location,
            "static_id": static_id
          }),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": _authToken
          });
      notifyListeners();
      final responseData = json.decode(response.body);
      print(responseData);
      //print({"authToken", authToken});
    } catch (e) {
      throw e;
    }
  }

  Future<void> getPressForCompany() async {
    try {
      // final url = Uri.parse('http://10.120.1.37:5001/press');
      final url = Uri.parse('http://localhost:5001/press');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });
      final data = json.decode(responseData.body) as Map<String, dynamic>;
      final jsonData = json.decode(responseData.body);
      PressList pressList = PressList.fromJson(data['presses']);
      final List<Press> presses = pressList.presses;
      print({presses[0].press_id});
      _presses = presses;
      print({_presses[0].press_id});
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> getPress(String pressId) async {
    try {
      final url = Uri.parse('http://localhost:5001/press/$pressId');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });
      var press = json.decode(responseData.body);

      print(press['press']['press_id']);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> removePress(String pressId) async {
    try {
      final url = Uri.parse('http://localhost:5001/press/$pressId');
      // final url = Uri.parse('http://117.99.60.241:5001/press/:$pressId');

      final responseData = await http.delete(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });
      _presses.remove(pressId);
      print(pressId);
      print(responseData);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }
}
