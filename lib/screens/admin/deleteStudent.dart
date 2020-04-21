import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/constants.dart';
import 'package:librarymanagementsystem/screens/admin/admin_login.dart';
import './crudStudent.dart';
import 'package:intl/intl.dart';
import 'newStudent.dart';

final _auth = FirebaseAuth.instance;

class DeleteStudent extends StatefulWidget {
  static const String id = 'delete_student';
  @override
  _DeleteStudentState createState() => _DeleteStudentState();
}

class _DeleteStudentState extends State<DeleteStudent> {
  var data;

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  String userId;

  crudMedthods crudObj = new crudMedthods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Delete User Records Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                userId = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter User ID'),
            ),
            RoundedButton(
              title: 'Delete Student',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, NewStudent.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
