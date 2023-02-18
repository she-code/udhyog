import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:udhyog/models/pressAvg.dart';
import 'package:udhyog/models/pressData.dart';
import 'package:udhyog/screens/newPress.dart';

import '../config/config.dart';
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

  List<PressAverage> _PressAverage = [];
  List<PressAverage> get PressAverages {
    return [..._PressAverage];
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
    final url = Uri.parse('http://192.168.254.16:5001/api/press');
    //final url = Uri.parse('http://192.168.53.189:5001/api/press');

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
      //final url = Uri.parse('http://192.168.13.189:5001/api/press');
      final url = Uri.parse('http://192.168.254.16:5001/api/press');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });
      final data = json.decode(responseData.body) as Map<String, dynamic>;
      PressList pressList = PressList.fromJson(data['presses']);
      final List<Press> presses = pressList.presses;
      _presses = presses;
      //print(_presses);
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<void> getPress(String pressId) async {
    try {
      final url = Uri.parse('http://192.168.13.189:5001/api/press/$pressId');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });
      final response = json.decode(responseData.body);
      final press = response['press'];
      final newPress = Press(
        TypeOfPress: press['TypeOfPress'],
        company_id: press['company_id'],
        createdAt: press['createdAt'],
        frequnecy: press['frequency'],
        hots_password: press['hots_password'],
        hotspot: press['hotspot'],
        location: press['location'],
        press_id: press['press_id'],
        press_name: press['press_name'],
        static_id: press['static_id'],
      );
      print(newPress);
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> removePress(String pressId) async {
    try {
      final url = Uri.parse('http://192.168.254.16:5001/api/press/$pressId');

      // final url = Uri.parse('http://192.168.13.189:5001/api/press/$pressId');

      final responseData = await http.delete(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });

      _presses.removeWhere(((element) => element.press_id == pressId));

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<void> updatePress(
      String pressId, String location, String static_id) async {
    try {
      final url = Uri.parse('http://192.168.254.16:5001/api/press/$pressId');

      // final url = Uri.parse('http://192.168.13.189:5001/api/press/$pressId');

      final responseData = await http.patch(url,
          body: json.encode({"location": location, "static_id": static_id}),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": _authToken
          });
      final results = responseData.body;
      print(results);
      // _presses.removeWhere(((element) => element.press_id == pressId));

      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<List<PressAverage>> getDailyTempLowPressData(String id) async {
    try {
      // final url = Uri.parse('http://192.168.13.189:5001/api/press/$id/daily');
      final url = Uri.parse('http://192.168.254.16:5001/api/press/$id/daily');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });

      final results = json.decode(responseData.body) as Map<String, dynamic>;
      PressAverageList pA = PressAverageList.fromJson(results['data']);
      final List<PressAverage> pressAvg = pA.PressAverages;
      _PressAverage = pressAvg;

      //  print(_PressAverage);
      notifyListeners();
      return _PressAverage;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<PressAverage>> getWeeklyPressData(String id) async {
    try {
      // final url = Uri.parse('http://192.168.13.189:5001/api/press/$id/weekly');
      final url = Uri.parse('http://192.168.254.16:5001/api/press/$id/weekly');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });

      final results = json.decode(responseData.body) as Map<String, dynamic>;
      PressAverageList pA = PressAverageList.fromJson(results['data']);
      final List<PressAverage> pressAvg = pA.PressAverages;
      _PressAverage = pressAvg;
      //print(_PressAverage);
      notifyListeners();
      return _PressAverage;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<PressAverage>> getMonthlyPressData(String id) async {
    try {
      // final url = Uri.parse('http://192.168.13.189:5001/api/press/$id/monthly');
      final url = Uri.parse('http://192.168.254.16:5001/api/press/$id/monthly');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _authToken
      });

      final results = json.decode(responseData.body) as Map<String, dynamic>;
      PressAverageList pA = PressAverageList.fromJson(results['data']);
      final List<PressAverage> pressAvg = pA.PressAverages;
      _PressAverage = pressAvg;
      // print(_pressData);
      notifyListeners();
      return _PressAverage;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  Future<List<PressAverage>> getCustomizedPressData(
      String id, String selectedDate) async {
    try {
      //final url = Uri.parse('http://192.168.13.189:5001/api/press/$id/customized');
      final url =
          Uri.parse('http://192.168.254.16:5001/api/press/$id/customized');
      final responseData = await http.post(url,
          body: json.encode({"selectedDate": selectedDate}),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "Authorization": _authToken
          });
      final results = json.decode(responseData.body) as Map<String, dynamic>;
      PressAverageList pA = PressAverageList.fromJson(results['data']);
      final List<PressAverage> pressAvg = pA.PressAverages;
      _PressAverage = pressAvg;
      // print(_pressData);
      notifyListeners();
      return _PressAverage;
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
