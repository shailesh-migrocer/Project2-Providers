// 
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HomeScreen.dart';
import 'ItemAddNotifier.dart';
import 'package:provider/provider.dart';
import 'Wish.dart';
import 'login.dart';
import 'package:firebase_core/firebase_core.dart';

import 'validScreen.dart';
// void main() {
//   runApp(MyApp());
// }
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//   runApp(MyApp());
//    }

Future<void> main() async {
  
      WidgetsFlutterBinding.ensureInitialized();
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var email = prefs.getString('email');
      print(email);
      runApp(MaterialApp(debugShowCheckedModeBanner: false,home: email == null ? MyApp() : WishesPage(email)));
    }
  
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return 
    // ChangeNotifierProvider<ItemAddNotifier>(
    //   create: (BuildContext context) {
    //     return ItemAddNotifier();
    //   },
    //   child: Firebase.initializeApp()
     FutureBuilder(
      // Initialize FlutterFire
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Something went wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return StartApp();
        }
        return Text("Loding");
      },
    );
  }
}

class StartApp extends StatelessWidget{
Widget build(BuildContext context){
    return MaterialApp(
        debugShowCheckedModeBanner: false,
       theme: ThemeData(
         brightness:Brightness.dark,
         primaryColor: Colors.lightBlue,
       ),
        home: Login(),
      // )
    );
  }
}
