import 'package:flutter/material.dart';

import 'AddItemScreen.dart';

class skipCompleted extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body:Center(child: Text("NO wishes created")),
      floatingActionButton: new FloatingActionButton(
        // elevation: 0.0,
        child: new Icon(Icons.add),
        // backgroundColor: Colors.red,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              // fullscreenDialog: true,
              builder: (context) {
                return AddItemsScreen(false);
              },
            ),
          );
        },
      ),
    );
  }
}