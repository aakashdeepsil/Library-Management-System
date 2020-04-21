import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/constants.dart';
import './crudStudent.dart';
import 'package:intl/intl.dart';

class NewStudent extends StatefulWidget {
  static const String id = 'new_student';
  @override
  _NewStudentState createState() => _NewStudentState();
}

class _NewStudentState extends State<NewStudent> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  String studentId, dept, email, mob, name, password;

  crudMedthods crudObj = new crudMedthods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("New User Page"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                studentId = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter The Student ID'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                name = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter The Name'),
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
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter The Password'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                dept = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter The Department'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                mob = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter The Mobile Number'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                email = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter The Email ID'),
            ),
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              title: 'Add Student',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.of(context).pop();
                crudObj.addData(this.studentId, {
                  'name': this.name,
                  'password': this.password,
                  'department': this.dept,
                  'mobile no': this.mob,
                  'email': this.email,
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
