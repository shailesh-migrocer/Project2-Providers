import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SkipLogin.dart';
import 'Wish.dart';
import 'verify.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String _email, _password,_reEnterPassword;
  final auth = FirebaseAuth.instance;
  bool showRenter = false;
  final formKey = GlobalKey<FormState>();
  String validateEmail(String value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    // if(mailStatus){
      if (value.length == 0) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else if (auth.currentUser.email != value) {
      return "${auth.currentUser.email}";
    } else {
      return null;
    }

  }
  String validateReEnterPassword(String value) {
    if (value.length <9) {
      return "Password less than 8";
    }
    else if(_email!=_reEnterPassword){
      return "password must match";
    }
    else{
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        autovalidate: true,
        key: formKey,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(hintText: 'Email'),
                  onChanged: (value) {
                    setState(() {
                      _email = value.trim();
                    });
                  },
                  validator: validateEmail,
                  onSaved: (String val) {
                    if(val.length==0){
                      _email = val;
                    }
                    
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                decoration: InputDecoration(hintText: 'Password'),
                onChanged: (value) {
                  setState(() {
                    _password = value.trim();
                  });
                },
                // validator: EmailValidator(errorText: "Reqired field"),
                validator: (val) {
                  if(val.length==0){
                     _password = val;
                     return "Required";
                  }
                  return null;
                   
                  }
              ),
            ),
            (showRenter
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(hintText: 'RE-Enter Password'),
                      onChanged: (value) {
                        setState(() {
                          _password = value.trim();
                        });
                      },
                      validator: validateReEnterPassword,
                  onSaved: (String val) {
                    _reEnterPassword = val;
                  }
                    ),
                  )
                : Text("")),
            Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
              RaisedButton(
                  color: Theme.of(context).accentColor,
                  child: Text('Signin'),
                  onPressed: () {
                    setState(() {
                      showRenter = false;
                    });
                    auth
                        .signInWithEmailAndPassword(
                            email: _email, password: _password)
                        .then((_) async {
                          SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('email', auth.currentUser.email);
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => WishesPage(_email)));
                    });
                  }),
              RaisedButton(
                
                color: Theme.of(context).accentColor,
                child: Text('Signup'),
                onPressed: () {
                  setState(() {
                    showRenter = true;
                  });
                  auth
                      .createUserWithEmailAndPassword(
                          email: _email, password: _password)
                      .then((_) {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => VerifyScreen()));
                  });
                },
              ),
              RaisedButton(
                color: Theme.of(context).accentColor,
                child: Text('Skip Login'),
                onPressed: () {
                  setState(() {
                    showRenter = false;
                  });
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => SkipLoginPage()));
                },
              )
            ])
          ],
        ),
      ),
    );
  }
}
