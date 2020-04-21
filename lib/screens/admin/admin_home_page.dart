import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/screens/admin/deleteBook.dart';
import 'package:librarymanagementsystem/screens/admin/deleteStudent.dart';
import 'package:librarymanagementsystem/screens/admin/newBook.dart';
import 'package:librarymanagementsystem/screens/admin/newStudent.dart';
import 'package:librarymanagementsystem/screens/admin/returnBook.dart';
import 'package:librarymanagementsystem/screens/admin/show_book.dart';
import 'package:librarymanagementsystem/screens/admin/issueBook.dart';
import 'package:librarymanagementsystem/screens/admin/updateBook.dart';

final _auth = FirebaseAuth.instance;

class AdminHomePage extends StatefulWidget {
  static const String id = 'admin_home_page';
  @override
  _AdminHomePageState createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('Admin Home Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            RoundedButton(
              title: 'Book',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Book()),
                );
              },
            ),
            RoundedButton(
              title: 'Student',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubStudent()),
                  //createRecord();
                );
              },
            ),
            RoundedButton(
              title: 'All Books',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, ShowBook.id);
              },
            ),
            RoundedButton(
              title: 'Issue Books',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, IssueBook.id);
              },
            ),
            RoundedButton(
              title: 'Return Book',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, ReturnBook.id);
              },
            ),
          ],
        ),
      ), //center
    );
  }
}

class Book extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Text("Book Records Page"),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            RoundedButton(
              title: 'New Record',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, NewBook.id);
              },
            ),
            RoundedButton(
              title: 'Update Record',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, UpdateBook.id);
              },
            ),
            RoundedButton(
              title: 'Delete Record',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, DeleteBook.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SubStudent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        title: Text('User Records Page'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              RoundedButton(
                title: 'New Record',
                colour: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, NewStudent.id);
                },
              ),
              RoundedButton(
                title: 'Delete Record',
                colour: Colors.lightBlueAccent,
                onPressed: () {
                  Navigator.pushNamed(context, DeleteStudent.id);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
