import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UserIssuedBooks extends StatefulWidget {
  static const String id = 'user_issued_books_screen';
  final String uId;

  UserIssuedBooks({this.uId});

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
    print(this.widget.uId);
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

  Future getBookDetails(dynamic bookId) async {
    final user = await firestore
        .collection('Library books')
        .document(bookId.toString())
        .get();
    return user;
//    bookAuthor = user.data['author'];
//    bookName = user.data['name'];
//    print(bookName);
//    print(bookAuthor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('Issued Book Page'),
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
                if (issue['userId'] == this.widget.uId) {
                  final bookId = issue['book_id'];
                  final returnDate = issue['Return Date'];
                  getBookDetails(bookId).then((value) {
                    bookAuthor = value['author'];
                    bookName = value['name'];
                  });

//                  print(books);
//
//                  getBookDetails(bookId).then((DocumentSnapshot value) {
//
//                  });
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
