import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firestore = Firestore.instance;
dynamic userId;
FirebaseUser loggedInUser;

class UserIssuedBooks extends StatefulWidget {
  static const String id = 'user_issued_books_screen';
  @override
  _UserIssuedBooksState createState() => _UserIssuedBooksState();
}

class _UserIssuedBooksState extends State<UserIssuedBooks> {
  final _auth = FirebaseAuth.instance;

  String bookName;
  String bookAuthor;

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
        getUserId();
      }
    } catch (e) {
      print(e);
    }
  }

  Future<DocumentSnapshot> getBookDetails(dynamic bookId) {
    final user =
        firestore.collection('Library books').document(bookId.toString()).get();
    return user;
  }

  void getUserId() {
    final user = firestore.collection('Users').getDocuments();
    user.then((QuerySnapshot docs) {
      for (int i = 0; i < docs.documents.length; ++i) {
        if (docs.documents[i].data["email"] == loggedInUser.email) {
          userId = i + 1;
          print(userId);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
        title: Text('User Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: <Widget>[
          StreamBuilder<QuerySnapshot>(
            stream: firestore.collection('Issue').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lightBlueAccent,
                  ),
                );
              }
              final issues = snapshot.data.documents;
              List<ListTile> bookWidgets = [];

              for (var issue in issues) {
                if (issue['userId'] == userId.toString()) {
                  final bookId = issue['book_id'];
                  final returnDate = issue['Return Date'];
                  final books = getBookDetails(bookId);

                  books.then((DocumentSnapshot value) {
                    bookAuthor = value['author'];
                    bookName = value['name'];
                  });
                  final bookWidget = ListTile(
                    title: Text('$bookName by $bookAuthor'),
                    subtitle: Text('Return Date : $returnDate'),
                  );
                  bookWidgets.add(bookWidget);
                }
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
