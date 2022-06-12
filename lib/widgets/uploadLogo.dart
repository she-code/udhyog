import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadLogo extends StatefulWidget {
  const UploadLogo({Key? key}) : super(key: key);

  @override
  State<UploadLogo> createState() => _UploadLogoState();
}

class _UploadLogoState extends State<UploadLogo> {
  File _pickedImage = File('');
  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage!.path);
    final imageForSendToAPI = await pickedImage.readAsBytes();
    setState(() {
      _pickedImage = pickedImageFile;
    });
    //pickImage(source: ImageSource.gallery);
  }

  void _uploadFile() async {
    var url = Uri.parse('https://localhost/users/logo');
    String base64Image = base64Encode(_pickedImage.readAsBytesSync());
    String fileName = _pickedImage.path.split('/').last;
    await http.post(url, body: {
      "image": "",
      "name": "",
    }).then((res) {
      print(res);
    }).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
