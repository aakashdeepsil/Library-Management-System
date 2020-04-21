import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/screens/admin/adminUpdate.dart';
import '../../constants.dart';
import './crudBook.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UpdateBook extends StatefulWidget {
  static const String id = 'update_dart';
  @override
  _UpdateBookState createState() => _UpdateBookState();
}

class _UpdateBookState extends State<UpdateBook> {
  final _auth = FirebaseAuth.instance;
  crudMedthods crudObj = new crudMedthods();
  String updateBookID;
  String rackNo;

  @override
  void initState() {
    super.initState();

    getCurrentUser();
  }

  void getCurrentUser() async {
    try {
      final user = await _auth.currentUser();
      if (user != null) {
        loggedInUser = user;
      }
    } catch (e) {
      print(e);
    }
  }

  void getBooks() async {
    await for (var snapshot
        in _firestore.collection('Library books').snapshots()) {
      for (var book in snapshot.documents) {
        print(book.data);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Update Book Records Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              onChanged: (value) {
                updateBookID = value;
              },
              textAlign: TextAlign.center,
              decoration:
                  kTextFieldDecoration.copyWith(hintText: 'Enter the book ID'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              textAlign: TextAlign.center,
              onChanged: (value) {
                rackNo = value;
              },
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'Enter the new Rack No'),
            ),
          ),
          RoundedButton(
            title: 'Update',
            colour: Colors.lightBlueAccent,
            onPressed: () {
              Navigator.of(context).pop();
              crudObj.updateData(updateBookID, {'rackNo': rackNo});
            },
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 20.0,
            ),
            child: Text(
              'List Of Books In The Library',
              style: TextStyle(
                decoration: TextDecoration.underline,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: _firestore.collection('Library books').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final books = snapshot.data.documents;
              List<ListTile> bookWidgets = [];

              for (var book in books) {
                final bookName = book['name'];
                final bookAuthor = book['author'];

                final bookWidget = ListTile(
                  title: Text('$bookName'),
                  subtitle: Text('$bookAuthor'),
                );
                bookWidgets.add(bookWidget);
              }
              return Expanded(
                child: ListView(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.0,
                    vertical: 20.0,
                  ),
                  children: bookWidgets,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
