import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Users with ChangeNotifier {
  Future<void> uploadImage(File uploadedImage, String authToken) async {
    final url = Uri.parse('http://localhost:5001/users/addLogo');
    try {
      List<int> imageBytes = uploadedImage.readAsBytesSync();
      String baseImage = base64Encode(imageBytes);
      var response = await http.patch(url, body: {
        'image': baseImage
      }, headers: {
        "Content-Type": "application/json",
        "Access-Control_Allow_Origin": "*",
        "Authorization": authToken
      });
      if (response.statusCode == 200) {
        var responseData = json.decode(response.body);
        print("Success");
      }
    } catch (e) {
      throw e;
    }
  }
}
