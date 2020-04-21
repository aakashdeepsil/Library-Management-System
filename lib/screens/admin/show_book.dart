import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import './crud.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class ShowBook extends StatefulWidget {
  static const String id = 'show_book';
  @override
  _ShowBookState createState() => _ShowBookState();
}

void getStatus() {
  var bookId = 1;

  final user = _firestore
      .collection('Library books')
      .document(bookId.toString())
      .get()
      .then((DocumentSnapshot val) {
    print(val["status"]);
  });
}

class _ShowBookState extends State<ShowBook> {
  final _auth = FirebaseAuth.instance;
  crudMedthods crudObj = new crudMedthods();
//  AlertDialog({Key key, Widget title, EdgeInsetsGeometry titlePadding, TextStyle titleTextStyle, Widget content, EdgeInsetsGeometry contentPadding: const EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 24.0), TextStyle contentTextStyle, List<Widget> actions, Color backgroundColor, double elevation, String semanticLabel, ShapeBorder shape }),

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
        title: Text('Book List'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: <Widget>[
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
            //stream: _firestore.collection('Library books').where('author',isEqualTo: 'ABC').snapshots(),
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
              RaisedButton(
                onPressed: () {
                  getStatus();
                  //Navigator.pushNamed(context, DeleteStudent.id);
                  //Navigator.pop(context);
                },
                child: Text('Delete Record!'),
              );
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
