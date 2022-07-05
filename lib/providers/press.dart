import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:udhyog/models/pressData.dart';

import '../models/press.dart';

class PressProvider with ChangeNotifier {
  late String _authToken;

  void authToken(String value) {
    _authToken = value;
  }

  Press findByID(String id) {
    return _presses.firstWhere((prod) => prod.press_id == id);
  }

  PressData pDataBYyId(String id) {
    return _pressData.firstWhere((prod) => prod.press_id == id);
  }

  PressProvider(this._authToken, this._presses);

  List<Press> _presses = [];

  List<Press> get presses {
    return [..._presses];
  }

  int get pressLength {
    return _presses.length;
  }

  List<PressData> _pressData = [];
  List<PressData> get pressdatas {
    return [..._pressData];
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
    //  final url = Uri.parse('http://192.168.66.189:5001/press');

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
      // final url = Uri.parse('http://192.168.138.189:5001/users/login');
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
      _presses = presses;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> getPress(String pressId) async {
    try {
      final url = Uri.parse('http://192.168.66.189:5001/press/$pressId');
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
      // final url = Uri.parse('http://localhost:5001/press/$pressId');
      final url = Uri.parse('http://localhost:5001/press/$pressId');

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

  Future<void> getDailyPressData(String id) async {
    try {
      // final url = Uri.parse('http://192.168.138.189:5001/users/login');
      final url = Uri.parse('http://localhost:5001/press/$id/daily');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });
      final data = json.decode(responseData.body) as Map<String, dynamic>;
      final jsonData = json.decode(responseData.body);
      PressDataList pressDataList = PressDataList.fromJson(data['presses']);
      final List<PressData> pressDataLists = pressDataList.pressDatas;
      _pressData = pressDataLists;
      print(_pressData);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> getWeeklyPressData(String id) async {
    try {
      // final url = Uri.parse('http://192.168.138.189:5001/users/login');
      final url = Uri.parse('http://localhost:5001/press/$id/weekly');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });
      final data = json.decode(responseData.body) as Map<String, dynamic>;
      final jsonData = json.decode(responseData.body);
      PressDataList pressDataList = PressDataList.fromJson(data['presses']);
      final List<PressData> pressDataLists = pressDataList.pressDatas;
      _pressData = pressDataLists;
      print(_pressData);
      notifyListeners();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> getMonthlyPressData(String id) async {
    try {
      // final url = Uri.parse('http://192.168.138.189:5001/users/login');
      final url = Uri.parse('http://localhost:5001/press/$id/monthly');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });
      final data = json.decode(responseData.body) as Map<String, dynamic>;
      final jsonData = json.decode(responseData.body);
      PressDataList pressDataList = PressDataList.fromJson(data['presses']);
      final List<PressData> pressDataLists = pressDataList.pressDatas;
      _pressData = pressDataLists;
      print(_pressData);
      notifyListeners();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> getCustomizedPressData(String id, String selectedDate) async {
    try {
      // final url = Uri.parse('http://192.168.138.189:5001/users/login');
      final url = Uri.parse('http://localhost:5001/press/$id/customized');
      final responseData = await http.post(url,
          body: json.encode({"selectedDate": selectedDate}),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": _authToken
          });
      final data = json.decode(responseData.body) as Map<String, dynamic>;
      final jsonData = json.decode(responseData.body);
      PressDataList pressDataList = PressDataList.fromJson(data['presses']);
      final List<PressData> pressDataLists = pressDataList.pressDatas;
      _pressData = pressDataLists;
      print(_pressData);
      notifyListeners();
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
