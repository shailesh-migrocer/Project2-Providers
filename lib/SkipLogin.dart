import 'package:flutter/material.dart';
import 'package:providers/AddItemScreen.dart';

import 'Skip_incomplete.dart';
import 'login.dart';

class SkipLoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.lightBlue,
      ),
      home: DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
              bottom: TabBar(
                tabs: [
                  Tab(text: "Incompleted Wish"),
                  Tab(text: "Completed Wish"),
                ],
              ),
            ),
            body: Container(
              child: TabBarView(children: [
                skipCompleted(),
                Center(child: Text("No wishes fullfilled")),
              ]),
            ),
            
            ),
      ),
    );
  }
}
