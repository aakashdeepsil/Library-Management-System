import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import '../../constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
class AdminUpdate extends StatelessWidget {
  static const String id = 'admin_update_screen';
  final String bookID;




  TextEditingController bookName = TextEditingController();
  TextEditingController bookAuthor = TextEditingController();
  TextEditingController bookPrice = TextEditingController();

  AdminUpdate({this.bookID});

    final _auth = FirebaseAuth.instance;

  @override



  Widget build(BuildContext context) {
    print("ID : "+this.bookID);
    var name="hi";
    var db = _firestore.collection('Library books').where("name",isEqualTo: "ABC").getDocuments();



    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('Admin Update Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(10),
              child: Text(
                'Update the details of the book',
                style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
            ),
            SizedBox(
              height: 50.0,
            ),
            TextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              controller: bookName,

              decoration: kTextFieldDecoration.copyWith(
                  hintText: name),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              textAlign: TextAlign.center,
              controller: bookAuthor,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: name),
            ),
            SizedBox(
              height: 10.0,
            ),
            TextField(
              keyboardType: TextInputType.text,
              textAlign: TextAlign.center,
              controller: bookPrice,
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter the price of the book'),
            ),
            SizedBox(
              height: 10.0,
            ),

            RoundedButton(
              title: 'Update Details',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
