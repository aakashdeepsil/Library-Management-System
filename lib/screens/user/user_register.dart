import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/constants.dart';
import 'package:librarymanagementsystem/screens/user/user_page.dart';

final firestore = Firestore.instance;

class UserRegister extends StatefulWidget {
  static const String id = 'user_register_screen';
  @override
  _UserRegisterState createState() => _UserRegisterState();
}

class _UserRegisterState extends State<UserRegister> {
  final _auth = FirebaseAuth.instance;

  bool showSpinner = false;

  String email;
  String password;
  String name;
  String mobileNumber;
  String department;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'User',
        ),
      ),
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.all(10),
                child: Text(
                  'User Register',
                  style: TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.w500,
                      fontSize: 30),
                ),
              ),
              SizedBox(
                height: 50.0,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  name = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your name'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  email = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter your email'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                maxLength: 10,
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  mobileNumber = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your mobile number'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  department = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your department'),
              ),
              SizedBox(
                height: 10.0,
              ),
              TextField(
                obscureText: true,
                textAlign: TextAlign.center,
                onChanged: (value) {
                  password = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'Enter your password'),
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                title: 'Create Account',
                colour: Colors.lightBlueAccent,
                onPressed: () async {
                  setState(() {
                    showSpinner = true;
                  });
                  try {
                    final user = await _auth.createUserWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Map<String, dynamic> data = {
                        'name': name,
                        'email': email,
                        'department': department,
                        'mobile no': mobileNumber,
                        'password': password,
                      };
                      final user = firestore.collection('Users').getDocuments();
                      user.then((QuerySnapshot docs) {
                        var length = docs.documents.length + 1;
                        firestore
                            .collection('Users')
                            .document(length.toString())
                            .setData(data);
                      });
                      Navigator.pushNamed(context, UserPage.id);
                    }

                    setState(() {
                      showSpinner = false;
                    });
                  } catch (e) {
                    setState(() {
                      showSpinner = false;
                    });
                    print(e);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
