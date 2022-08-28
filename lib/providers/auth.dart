import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:mime/mime.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:udhyog/models/auth.dart';

import '../models/http_exception.dart';

class Auth with ChangeNotifier {
  String? _token;
  DateTime? _expiryDate;
  String? userId;
  String? company;
  String? city;
  String? logo;
  Timer? _authTimer;
  bool get isAuth {
    return token != null;
  }

  String? get token {
    if (_expiryDate != null &&
        _expiryDate!.isAfter(DateTime.now()) &&
        _token != null) {
      print({"tok", _token});
      return _token;
    }
    return null;
  }

  List<User> _users = [];
  List<User> get users {
    return [..._users];
  }

  User? _me;
  User get me {
    return _me!;
  }

  User findById(String id) {
    return _users.firstWhere((element) => element.company_id == id);
  }

  Future<User> myProfile() async {
    try {
      // final url = Uri.parse('http://localhost:5001/users/me');
      final url = Uri.parse('http://192.168.13.189:5001/users/me');

      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _token!
      });
      final response = json.decode(responseData.body);
      final user = response['user'];
      final newUser = User(
          company: user['company'],
          email: user['email'],
          city: user['city'],
          country: user['country'],
          state: user['state'],
          address1: user['address1'],
          address2: user['address2'],
          webpage: user['webpage'],
          logo: "user['logo']",
          cellNo: user['cellNo'],
          pin: user['pin'],
          gst: user['gst'],
          gstNo: user['gstNo'],
          createdAt: user['createdAt'],
          contactPerson: user['contactPerson']);
      //print({newUser.address1});
      _me = newUser;
      notifyListeners();
      return newUser;
    } catch (e) {
      throw e;
    }
  }

  Future<void> getUSers() async {
    try {
      //final url = Uri.parse('http://192.168.66.189:5001/press');
      final url = Uri.parse('http://localhost:5001/users');
      final responseData = await http.get(url, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": _token!
      });
      //print(json.decode(responseData.body));
      final data = json.decode(responseData.body) as Map<String, dynamic>;
      final jsonData = json.decode(responseData.body);
      UsersList usersList = UsersList.fromJson(data['clients']);
      final List<User> users = usersList.users;
      _users = users;
      notifyListeners();
    } catch (e) {
      print(e.toString());
      throw e;
    }
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
      File image,
      String webpage) async {
    // final url = Uri.parse('http://192.168.94.189:5001/users/register');
    final url = Uri.parse('http://localhost:5001/users/register');

    // final response = await http.post(url,
    //     body: json.encode(
    //       {
    //         // "company_id": company_id,
    //         "company": company,
    //         "email": email,
    //         "password": password,
    //         "address1": address1,
    //         "address2": address2,
    //         "city": city,
    //         "pin": pin,
    //         "image": image,
    //         "state": state,
    //         "country": country,
    //         "cellNo": cellNo,
    //         "gst": gst,
    //         "gstNo": gstNo,
    //         "contactPerson": contactPerson,
    //         "webpage": webpage
    //       },
    //     ),
    //     headers: {
    //       "Content-Type": "application/json",
    //       "Access-Control_Allow_Origin": "*",
    //       "accept": "application/json"
    //     }
    //     //{"Accept": "application/json"},
    //     );
    var stream = http.ByteStream(image.openRead());
    stream.cast();
    var length = await image.length();
    var request = http.MultipartRequest(
      'POST',
      url,
    );
    // request.fields['company'] = "title";
    request.fields["company"] = company;
    request.fields["email"] = email;
    request.fields["password"] = password;
    request.fields["address1"] = address1;
    request.fields["address2"] = address2;
    request.fields["city"] = city;
    request.fields["pin"] = pin.toString();
    //request.fields["logo"] = logo;
    request.fields["state"] = state;
    request.fields["country"] = country;
    request.fields["cellNo"] = cellNo.toString();
    request.fields["gst"] = gst;
    request.fields["gstNo"] = gstNo;
    request.fields["contactPerson"] = contactPerson;
    request.fields["webpage"] = webpage;
    var multipart = http.MultipartFile('logo', stream, length);
    // request.files.add(multipart);
    print(image);
    // request.files.add(multipart);
    // request.files
    //     .add(http.MultipartFile.fromBytes('logo', await image.readAsBytes(),
    //         // image.lengthSync(),
    //         filename: image.path.split("/").last,
    //         contentType: new MediaType('image', 'jpeg')));
    String fileName = image.path.split('/').last;
    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])!.split('/');

    request.files.add(await http.MultipartFile.fromPath('logo', image.path,
        contentType: MediaType(mimeTypeData[0], mimeTypeData[1])));
    request.headers.addAll({
      "Content-Type": 'multipart/form-data',
      "Access-Control_Allow_Origin": "*",
      //"accept": "application/json"
    });
    var response = await request.send();
    if (response.statusCode == 200) {
      print("image uploaded");
    }

    // print({'body', json.decode(response.body)});
    // final responseData = response;
    // // print({'body', responseData});
    // if (responseData['error'] != null) {
    //   print(responseData['error']['message']);
    //   throw HttpException(responseData['error']['message']);
    // }

    // _token = responseData['token'];
    // userId = responseData['id'].toString();
    // _expiryDate = DateTime.now()
    //     .add(Duration(seconds: int.parse(responseData['expiresIn'])));
    // company = responseData['company'];
    // city = responseData['city'];
    // logo = responseData['logo'];
    // // print({"token", _token});
    // final newUser = User(
    //     company_id: responseData['company_id'],
    //     company: responseData['company'],
    //     email: responseData['email'],
    //     city: responseData['city'],
    //     country: responseData['country'],
    //     state: responseData['state'],
    //     address1: responseData['address1'],
    //     address2: responseData['address2'],
    //     webpage: responseData['webpage'],
    //     logo: responseData['logo'],
    //     cellNo: responseData['cellNo'],
    //     pin: responseData['pin'],
    //     gst: responseData['gst'],
    //     gstNo: responseData['gstNo'],
    //     createdAt: responseData['createdAt']);
    // _users.add(newUser);
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    final userData = json.encode({
      'token': _token,
      'userId': userId,
      'expiryDate': _expiryDate!.toIso8601String(),
    });
    prefs.setString('userData', userData);
    // if (!prefs.containsKey('userData')) {
    //   return null;
    // }
  }

  Future<void> signin(String email, String password) async {
    final url = Uri.parse('http://192.168.13.189:5001/users/login');
    // final url = Uri.parse('http://localhost:5001/users/login');
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
      userId = responseData['id'].toString();
      _expiryDate = DateTime.now()
          .add(Duration(seconds: int.parse(responseData['expiresIn'])));
      company = responseData['company'];
      city = responseData['city'];
      logo = responseData['logo'];
      print({responseData, city});
      // print({"token", _token});

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'token': _token,
        'userId': userId,
        'expiryDate': _expiryDate!.toIso8601String(),
        'company': company,
        'city': city,
        'logo': logo
      });
      prefs.setString('userData', userData);
      // if (!prefs.containsKey('userData')) {
      //   return null;
      // }
      _autoLogout();
      notifyListeners();
    } catch (e) {
      // TODO
      throw e;
    }
  }

  Future<bool> tryAutoLogin() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      if (!prefs.containsKey('userData')) {
        print("No token stored");
        return false;
      }
      final extractedUserData =
          json.decode(prefs.getString('userData')!) as Map<String, dynamic>;
      final expiryDate =
          DateTime.parse(extractedUserData['expiryDate'].toString());
      if (expiryDate.isBefore(DateTime.now())) {
        print("expired");
        return false;
      }
      _token = extractedUserData['token'].toString();
      userId = extractedUserData['userId'].toString();
      company = extractedUserData['company'].toString();
      city = extractedUserData['city'].toString();
      _expiryDate = expiryDate;
      logo = extractedUserData['logo'];
      // print({_token});
      print({extractedUserData});

      notifyListeners();
    } on Exception catch (e) {
      print(e.toString());
      // TODO
    }
    // _authoLogout();

    return true;
  }

  Future<void> logout() async {
    _expiryDate = null;
    _token = null;
    userId = null;
    company = null;
    city = null;
    logo = null;
    if (_authTimer != null) {
      _authTimer!.cancel();
      _authTimer = null;
    }

    final prefs = await SharedPreferences.getInstance();
    // clear to clear all , remove to remove specific
    prefs.remove('userData');
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer!.cancel();
    }
    final timeToExpiry = _expiryDate!.difference(DateTime.now()).inSeconds;
    print(timeToExpiry);
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future<void> uploadImage() async {}
}
