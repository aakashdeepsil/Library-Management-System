import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:librarymanagementsystem/components/rounded_button.dart';
import 'package:librarymanagementsystem/screens/admin/admin_login.dart';
import 'package:librarymanagementsystem/screens/user/user_login.dart';

final firestore = Firestore.instance;

class WelcomePage extends StatefulWidget {
  static const String id = 'welcome_screen';
  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: Duration(seconds: 3), vsync: this);
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);
    controller.forward();
    controller.addListener(() {
      setState(() {});
    });
    //getStatus();
  }

  void getStatus() {
    var bookId = 1;

    firestore
        .collection('Library books')
        .document(bookId.toString())
        .get()
        .then((DocumentSnapshot val) {
      print(val["status"]);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Home Page',
          ),
        ),
      ),
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('images/books.png'),
                    height: 60.0,
                  ),
                ),
                Expanded(
                  child: TypewriterAnimatedTextKit(
                    textAlign: TextAlign.center,
                    text: ['Library Management System'],
                    textStyle: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 25.0,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50.0,
            ),
            RoundedButton(
              title: 'Admin',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, AdminLogin.id);
              },
            ),
            SizedBox(
              height: 10.0,
            ),
            RoundedButton(
              title: 'User',
              colour: Colors.lightBlueAccent,
              onPressed: () {
                Navigator.pushNamed(context, UserLogin.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}
