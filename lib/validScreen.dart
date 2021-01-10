import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// import 'HomeScreen.dart';
import 'SignUp.dart';
import 'SkipLogin.dart';
import 'Wish.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  String _error;
  final _auth = FirebaseAuth.instance;
  String email;
  String password;
  // String retypepassword;
  bool invalid = false;

  bool isValidEmail(email) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
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
                  "Make",
                  
                  style: TextStyle(fontStyle: FontStyle.italic,fontSize: 25),
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
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  FlatButton(
                      child: Text(
                        'sign in',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      color: Colors.blue,
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          try {
                            final res = await _auth.signInWithEmailAndPassword(
                                email: email, password: password);
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            prefs.setString('email', _auth.currentUser.email);

                            var Kemail = email;

                            if (res != null) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => WishesPage(email))

                                      );
                              // Navigator.of(context, rootNavigator: true).push(
                              //   CupertinoPageRoute<void>(
                              //     title: "login",
                              //     builder: (BuildContext context) =>
                              //         WishesPage(email),
                              //   ),
                              // );
                              // Navigator.of(context).pushReplacementNamed('/Wish');
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
                  SizedBox(
                    width: 20,
                  ),
                  FlatButton(
                    child: Text(
                      'skip ',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.blue,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SkipLoginPage()),
                      );
                    },
                  ),
                ],
              ),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(children: <InlineSpan>[
                    TextSpan(
                        text: 'New user?',
                        style: TextStyle(color: Colors.white)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => signup()));
                          },
                        text: 'Sign up',
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold)),
                  ]),
                ),
              ),
              showAlert(),
            ],
          ),
        ),
      ),
    );
  }

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
