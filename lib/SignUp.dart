import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomeScreen.dart';
import 'Wish.dart';

class signup extends StatefulWidget {
  @override
  _signupState createState() => _signupState();
}

class _signupState extends State<signup> {
  String _error;
  final _auth = FirebaseAuth.instance;
  String email;
  String password,reEnterpassword;
  // String retypepassword;
  bool invalid = false;

  bool isValidEmail(email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
  bool isRetypePassword(String retypepassword)
  {
    if(retypepassword==password)
      {
        return true;
      }
    return false;
  }

  bool isValidPassword(String password) {
    if (password.length == 0) {
      return false;
    }
    if (password.length < 8) {
      return false;
    }

    return true;
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              SafeArea(
                child: Text(
                  "WISHBUCKET",
                ),
              ),
              Flexible(
                child: TextFormField(
                    onChanged: (value) {
                      email = value;
                      //Do something with the user input.
                    },
                    decoration: InputDecoration(hintText: 'Enter your email'),
                    validator: (input) {
                      if (input.isEmpty) {
                        return "invalid email";
                      } else if (isValidEmail(email)) {
                        return null;
                      }
                      return "Check your email";
                    }),
              ),
              Flexible(
                child: TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      password = value;
                      //Do something with the user input.
                    },
                    decoration:
                        InputDecoration(hintText: 'Enter your password'),
                    // ignore: deprecated_member_use
                    //autovalidate: true,
                    validator: (input) {
                      if (input.isEmpty) {
                        return "invalid password";
                      } else if (isValidPassword(password)) {
                        return null;
                      }
                      // return "Password must contain 8 characters";
                    }),
              ),
              Flexible(
                child: TextFormField(
                    obscureText: true,
                    onChanged: (value) {
                      reEnterpassword = value;
                      //Do something with the user input.
                    },
                    decoration:
                        InputDecoration(hintText: 'ReEnter your password'),
                    // ignore: deprecated_member_use
                    //autovalidate: true,
                    validator: (input) {
                      if (input.isEmpty) {
                        return "invalid password";
                      } else if (isRetypePassword(reEnterpassword)) {
                        return null;
                      }
                     else if (isValidPassword(reEnterpassword)) {
                        return null;
                      }
                      // ret
                      // return "Password must contain 8 characters";
                    }),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      child: Text(
                        'sign up',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            final res = await _auth.createUserWithEmailAndPassword(
                                email: email, password: password);

                            var Kemail = email;

                            if (res != null) {
                              SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('email', _auth.currentUser.email);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WishesPage(email)));
                            }
                          } catch (e) {
                            setState(() {
                              _error = e.message;
                              var k = 1;
                            });

                            print("exception caught");
                          }
                        }
                      }),
                  
                ],
              ),
              
              showAlert(),
            ],
          ),
        ),
      ),
    );
  }

//   Widget showAlert() {
//     if (_error != null) {
//       return Container(
//         color: Colors.amberAccent,
//         width: double.infinity,
//         padding: EdgeInsets.all(8.0),
//         child: Row(
//           children: <Widget>[
//             Padding(
//               padding: const EdgeInsets.only(right: 8.0),
//               child: Icon(Icons.error_outline),
//             ),
//             Expanded(
//               child: Text(
//                 _error,
//                 maxLines: 3,
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 8.0),
//               child: IconButton(
//                 icon: Icon(Icons.close),
//                 onPressed: () {
//                   setState(() {
//                     _error = null;
//                   });
//                 },
//               ),
//             )
//           ],
//         ),
//       );
//     }
//     return SizedBox(
//       height: 0,
//     );
//   }
// }
 Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.white,
        width: double.infinity,
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline,color: Colors.blue.shade400),
            ),
            Expanded(
              child: Text(
                _error,
                maxLines: 3,
                style: TextStyle(color: Colors.black.withOpacity(0.6),fontWeight: FontWeight.bold),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close,color: Colors.blue.shade400),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            )
          ],
        ),
      );
    }
    return SizedBox(
      height: 0,
    );
  }
}
