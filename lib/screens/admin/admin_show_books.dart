import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;
FirebaseUser loggedInUser;

class AdminPage extends StatefulWidget {
  static const String id = 'admin_page_screen';
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final _auth = FirebaseAuth.instance;

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
        leading: Container(),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                getBooks();
//                _auth.signOut();
//                Navigator.pop(context);
              }),
        ],
        title: Text('Administrator Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: <Widget>[
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
              List<Text> bookWidgets = [];

              for (var book in books) {
                final bookName = book['name'];
                final bookAuthor = book['author'];
                final bookType = book['type'];
                final bookAvailability = book['no of books'].toString();

                final bookWidget = Text(
                    '$bookName : $bookAuthor : $bookAvailability : $bookType');
                bookWidgets.add(bookWidget);
              }
              return Column(
                children: bookWidgets,
              );
            },
          ),
        ],
      ),
    );
  }
}
