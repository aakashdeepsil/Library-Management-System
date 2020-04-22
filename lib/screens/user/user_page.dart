import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/screens/user/search_page.dart';
import 'package:librarymanagementsystem/screens/user/user_issued_books.dart';
import 'package:librarymanagementsystem/screens/user/user_profile.dart';

final firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UserPage extends StatefulWidget {
  static const String id = 'user_page_screen';
  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  final _auth = FirebaseAuth.instance;
  var id;

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

  getUserId() async {
    QuerySnapshot querySnapshot =
        await firestore.collection('Users').getDocuments();
    var users = querySnapshot.documents;
    for (var user in users) {
      if (user.data['email'] == loggedInUser.email) {
        id = user.documentID;
        print(id);
        break;
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
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('User Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RoundedButton(
              title: 'View User Profile',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, UserProfile.id);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              title: 'Issued Books',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserIssuedBooks(
                      uId: id,
                    ),
                  ),
                );
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              title: 'Search books',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, SearchPage.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
//SearchPage(),
