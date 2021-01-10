import 'package:flutter/material.dart';
import 'Item.dart';
List<Item> itemList = [];
class ItemAddNotifier extends ChangeNotifier {
addItem(String title, String discription) async {
    Item item = Item(title, discription,false);
    itemList.add(item);
    notifyListeners();
  }
}