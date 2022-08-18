import 'package:flutter/material.dart';

class ItemModel {
  bool expanded;
  String headerItem;
  Widget discription;
  Color colorsItem;

  ItemModel({
    this.expanded = false,
    this.headerItem = '',
    this.discription = const SizedBox(),
    this.colorsItem = Colors.white,
  });
}
