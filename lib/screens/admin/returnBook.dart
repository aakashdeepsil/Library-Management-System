import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/constants.dart';
import './crudIssueBook.dart';

class ReturnBook extends StatefulWidget {
  static const String id = 'return_book';
  @override
  _ReturnBookState createState() => _ReturnBookState();
}

class _ReturnBookState extends State<ReturnBook> {
  var data;

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  String bookId;
  String userId;

  final _auth = FirebaseAuth.instance;

  CrudMethods crudObj = new CrudMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Return Book Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (value) {
                bookId = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Book ID'),
            ),
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              title: 'Return  Book',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.of(context).pop();
                crudObj.deleteData(this.bookId);
              },
            ),
          ],
        ),
      ),
    );
  }
}
