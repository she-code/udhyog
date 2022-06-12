import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddImage extends StatefulWidget {
  const AddImage({Key? key}) : super(key: key);

  @override
  State<AddImage> createState() => _AddImageState();
}

class _AddImageState extends State<AddImage> {
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

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          child: Text(
            "Company Logo",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        Container(
            child: TextButton.icon(
                onPressed: _pickImage,
                icon: Icon(
                  Icons.image,
                  color: Theme.of(context).primaryColorDark,
                ),
                label: Text(
                  'Add Image',
                  style: TextStyle(color: Theme.of(context).primaryColorDark),
                ))),
      ],
    );
  }
}
