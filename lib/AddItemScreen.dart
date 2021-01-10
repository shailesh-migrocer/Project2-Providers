import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Item.dart';
import 'ItemAddNotifier.dart';
import 'login.dart';
import 'validScreen.dart';

class AddItemsScreen extends StatelessWidget {
  
  final String title = 'Add items';
  Item item;
  bool loginstatus=true;
  AddItemsScreen(this.loginstatus);
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _discriptionController = TextEditingController();
  Widget build(BuildContext context) {
    return 
    // ChangeNotifierProvider<ItemAddNotifier>(
    //   create: (BuildContext context) {
    //     return ItemAddNotifier();
    //   },
    // child:
    Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Container(
        padding: EdgeInsets.all(30.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'title',
              ),
            ),
            TextField(
              controller: _discriptionController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(15.0),
                hintText: 'discription',
              ),
            ),
            SizedBox(
              height: 20.0,
            ),
            RaisedButton(
              child: Text('Create'),
              onPressed: () async {
                if (_titleController.text.isEmpty || _discriptionController.text.isEmpty) {
                  return;
                }
                else if(loginstatus){
                await Provider.of<ItemAddNotifier>(context, listen: false)
                    .addItem(_titleController.text,_discriptionController.text);
                Navigator.pop(context);
                }
                else{
          //         Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     fullscreenDialog: true,
          //     builder: (context) {
          //       return Login();
          //     },
          //   ),
          // );
          // Navigator.pushReplacement(context,
          //             MaterialPageRoute(builder: (context) => LoginScreen()));
          Navigator.push(
            context,
            MaterialPageRoute(
              // fullscreenDialog: true,
              builder: (context) {
                return Login();
              },
            ),
          );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
