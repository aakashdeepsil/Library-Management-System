import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/constants.dart';
import './crudBook.dart';
import 'package:intl/intl.dart';

class DeleteBook extends StatefulWidget {
  static const String id = 'delete_book';
  @override
  _DeleteBookState createState() => _DeleteBookState();
}

class _DeleteBookState extends State<DeleteBook> {
  var data;

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  String bookId;

  crudMedthods crudObj = new crudMedthods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Delete Book Records Page"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                bookId = value;
              },
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter The Book ID'),
            ),
            RoundedButton(
              title: 'Delete Book',
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
