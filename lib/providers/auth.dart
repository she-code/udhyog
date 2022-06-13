import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  late String _token;
  DateTime? _expiryDate = null;
  late String _userId;
  late String company;
  late String city;
  late String logo;
  // Timer _authTimer;
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      //print({"tok", _token});
      return _token;
    }
    return null;
  }

  Future<void> signup(
      // String company_id,
      String company,
      String email,
      String password,
      String address1,
      String address2,
      String city,
      int pin,
      String state,
      String country,
      int cellNo,
      String gst,
      String gstNo,
      String contactPerson,
      String logo,
      String webpage) async {
    // final url = Uri.parse('http://192.168.58.189:5001/users/register');
    final url = Uri.parse('http://localhost:5001/users/register');

    final response = await http.post(url,
        body: json.encode(
          {
            // "company_id": company_id,
            "company": company,
            "email": email,
            "password": password,
            "address1": address1,
            "address2": address2,
            "city": city,
            "pin": pin,
            "logo": logo,
            "state": state,
            "country": country,
            "cellNo": cellNo,
            "gst": gst,
            "gstNo": gstNo,
            "contactPerson": contactPerson,
            "webpage": webpage
          },
        ),
        headers: {
          "Content-Type": "application/json",
          "Access-Control_Allow_Origin": "*",
          "accept": "application/json"
        }
        //{"Accept": "application/json"},
        );

    print({'body', json.decode(response.body)});
    final responseData = json.decode(response.body);
    // print({'body', responseData});
    if (responseData['error'] != null) {
      print(responseData['error']['message']);
      throw HttpException(responseData['error']['message']);
    }

    _token = responseData['token'];
    _userId = responseData['id'].toString();
    _expiryDate = DateTime.now()
        .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    company = responseData['company'];
    city = responseData['city'];
    logo = responseData['logo'];
    // print({"token", _token});
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'userId': _userId,
      'expiryDate': _expiryDate!.toIso8601String(),
    });
    prefs.setString('userData', userData);
    // if (!prefs.containsKey('userData')) {
    //   return null;
    // }
  }

  Future<void> signin(String email, String password) async {
    //final url = Uri.parse('http://10.120.1.37:5001/users/login');
    final url = Uri.parse('http://localhost:5001/users/login');
    print({password, email});
    try {
      final response = await http.post(url,
          body: json.encode(
            {"email": email, "password": password},
          ),
          headers: {
            "Content-Type": "application/json",
            "Access-Control_Allow_Origin": "*",
            "accept": "application/json"
          }
          //{"Accept": "application/json"},
          );
      final responseData = json.decode(response.body);
      // print({'body', responseData});
      if (responseData['error'] != null) {
        print(responseData['error']['message']);
        throw HttpException(responseData['error']['message']);
      }

      _token = responseData['token'];
      _userId = responseData['id'].toString();
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      company = responseData['company'];
      city = responseData['city'];
      logo = responseData['logo'];
      print({responseData, city});
      // print({"token", _token});
      notifyListeners();

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': _userId,
        'expiryDate': _expiryDate!.toIso8601String(),
      });
      prefs.setString('userData', userData);
      // if (!prefs.containsKey('userData')) {
      //   return null;
      // }
    } catch (e) {
      // TODO
      throw e;
    }
  }

  Future<void> logout() async {
    // _token = null;
    // _userId = null;
    // _expiryDate = null;
    // if (_authTimer != null) {
    //   _authTimer.canecl();
    // }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // clear to clear all , remove to remove specific
    prefs.clear();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      print("No token stored");
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, Object>;
    final expiryDate =
        DateTime.parse(extractedUserData['expiryDate'].toString());
    if (expiryDate.isBefore(DateTime.now())) {
      print("expired");
      return false;
    }
    _token = extractedUserData['token'].toString();
    _userId = extractedUserData['userId'].toString();
    _expiryDate = expiryDate;
    notifyListeners();
    // _authoLogout();
    print({extractedUserData});
    return true;
  }
}
