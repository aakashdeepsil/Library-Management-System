import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/constants.dart';
import './crudIssueBook.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class IssueBook extends StatefulWidget {
  static const String id = 'issue_book';
  @override
  _IssueBookState createState() => _IssueBookState();
}

class _IssueBookState extends State<IssueBook> {
  var data;
  final _auth = FirebaseAuth.instance;

  bool autoValidate = true;
  bool readOnly = false;
  bool showSegmentedControl = true;

  String bookId;
  String userId;

  CrudMethods crudObj = new CrudMethods();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Book Issue Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Center(
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
                  userId = value;
                },
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'Enter User ID'),
              ),
              SizedBox(
                height: 10.0,
              ),
              RoundedButton(
                title: 'Issue Book',
                colour: Colors.lightBlueAccent,
                onPressed: () {
                  var db = _firestore
                      .collection('Library books')
                      .where('author', isEqualTo: 'Jatin Gandhi')
                      .snapshots();

                  var now = new DateTime.now();
                  var date = new DateFormat("yyyy-MM-dd hh:mm:ss").format(now);
                  var date1 = DateTime.parse(date);
                  var returnDate = date1.add(new Duration(days: 15));
                  var returnDate1 =
                      new DateFormat("yyyy-MM-dd hh:mm:ss").format(returnDate);

                  Navigator.of(context).pop();

                  crudObj.addData(this.bookId, {
                    'book_id': this.bookId,
                    'userId': this.userId,
                    'Issue Time': date,
                    'Return Date': returnDate1,
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
