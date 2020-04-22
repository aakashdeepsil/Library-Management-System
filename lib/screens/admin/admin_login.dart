import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:librarymanagementsystem/screens/admin/admin_home_page.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:librarymanagementsystem/constants.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/components/validation_mixin.dart';

class AdminLogin extends StatefulWidget {
  static const String id = 'admin_login_screen';
  @override
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> with ValidationMixin {
  final _auth = FirebaseAuth.instance;
  bool showSpinner = false;
  String email;
  String password;

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Administration',
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.all(10),
                  child: Text(
                    'Admin Login',
                    style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w500,
                        fontSize: 30),
                  ),
                ),
                SizedBox(
                  height: 50.0,
                ),
                TextFormField(
                  validator: validateEmail,
                  onSaved: (String value) {
                    email = value;
                  },
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
//                  onChanged: (value) {
//                    email = value;
//                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your email'),
                ),
                SizedBox(
                  height: 10.0,
                ),
                TextFormField(
                  validator: validatePassword,
                  onSaved: (String value) {
                    password = value;
                  },
                  controller: passwordController,
                  obscureText: true,
                  textAlign: TextAlign.center,
//                  onChanged: (value) {
//                    password = value;
//                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'Enter your password'),
                ),
                SizedBox(
                  height: 10.0,
                ),
//              FlatButton(
//                onPressed: () {
////forgot password screen
//                },
//                textColor: Colors.blue,
//                child: Text('Forgot Password'),
//              ),
//              SizedBox(
//                height: 24.0,
//              ),
                RoundedButton(
                  title: 'Log In',
                  colour: Colors.lightBlueAccent,
                  onPressed: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      if (formKey.currentState.validate()) {
                        formKey.currentState.save();
                      }
                      final user = await _auth.signInWithEmailAndPassword(
                          email: email, password: password);
                      if (user != null) {
                        emailController.clear();
                        passwordController.clear();
                        Navigator.pushNamed(context, AdminHomePage.id);
                      }

                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      setState(() {
                        showSpinner = false;
                      });
                      print(e);
                      showAlertDialog(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

showAlertDialog(BuildContext context) {
  // Create button
  Widget okButton = FlatButton(
    child: Text("OK"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // Create AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("ALERT!!"),
    content: Text("Please enter correct credentials!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
