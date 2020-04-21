import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/constants.dart';
import './crudBook.dart';
import 'package:intl/intl.dart';

class NewBook extends StatefulWidget {
  static const String id = 'new_book';
  @override
  _NewBookState createState() => _NewBookState();
}

class _NewBookState extends State<NewBook> {
  var data;
  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;
  String bookId, author, name, price, rackNo, status, type;

  crudMedthods crudObj = new crudMedthods();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("New Book Records Page"),
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
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                name = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Book Name'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                author = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Author Name'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                price = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Price of Book'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                rackNo = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Rack No'),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                type = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter Type(Dept)'),
            ),
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              title: 'Add Book',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.of(context).pop();
                crudObj.addData(this.bookId, {
                  'author': this.author,
                  'name': this.name,
                  'price': this.price,
                  'rackNo': this.rackNo,
                  'status': true,
                  'type': this.type,
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
