import 'package:flutter/material.dart';
import 'ItemDetails.dart';
import 'WishItem.dart';

class CompleteWishList extends StatelessWidget {
  WishItem wishList;
  CompleteWishList() : super();
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.white,
        body: Padding(
      padding: EdgeInsets.all(15.0),
      child: ListView.builder(
          itemCount: itemList2.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('title: ${itemList2[index].title}'),
              subtitle: Text('discription: ${itemList2[index].discription}'),
            );
          }),
    ));
  }
}
