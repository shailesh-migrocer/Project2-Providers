import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'CompleteWishScreen.dart';
import 'HomeScreen.dart';
import 'ItemAddNotifier.dart';
class WishesPage extends StatefulWidget{
  String emailID;
  static FirebaseAuth auth = FirebaseAuth.instance;
  WishesPage(this.emailID);

  @override
  _WishesPageState createState() => _WishesPageState();
}

class _WishesPageState extends State<WishesPage> {
  
  Widget build(BuildContext context){
    return ChangeNotifierProvider<ItemAddNotifier>(
      create: (BuildContext context) {
        return ItemAddNotifier();
      },
      child: MaterialApp(
      debugShowCheckedModeBanner: false,
       theme: ThemeData(
         brightness:Brightness.dark,
         primaryColor: Colors.lightBlue,
       ),
       home: DefaultTabController(
         length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text("${widget.emailID}"),
            actions: <Widget>[
              FlatButton.icon(onPressed: () async {
              //   Future(() async {
              //   if (WishesPage.auth != null) {
              //     Navigator.pushReplacement(context,
              //         MaterialPageRoute(builder: (context) => LoginScreen()));
              //   }
              // });
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.remove('email');
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (BuildContext ctx) => MyApp()));
              }, icon: Icon(Icons.person), label: Text("Logout"))
            ],
            bottom: TabBar(
              tabs: [
                Tab(text:"Incompleted Wish"),
                Tab(text:"Completed Wish"),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              HomeScreen(),
              // Text("Completed Wish Page"),
              CompleteWishList(),
            ])
        )
        )
      )
    );
  }
}