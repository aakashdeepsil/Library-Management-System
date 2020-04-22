import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

final firestore = Firestore.instance;
FirebaseUser loggedInUser;

class UserProfile extends StatefulWidget {
  static const String id = 'user_profile_screen';
  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  final _auth = FirebaseAuth.instance;

  var userData = [];

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
        getUserData();
      }
    } catch (e) {
      print(e);
    }
  }

  void getUserData() {
    final user = firestore
        .collection('Users')
        .where('email', isEqualTo: loggedInUser.email)
        .getDocuments();
    user.then((QuerySnapshot docs) {
      for (int i = 0; i < docs.documents.length; ++i) {
        print(docs.documents[i].data);
        setState(() {
          userData.add(docs.documents[i].data);
        });
      }
    });
  }

  void showData() {
    userData.map((element) {
      print(element);
      return buildResultCard(element);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      appBar: AppBar(
        leading: null,
        title: Text('User Profile'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Center(
        child: GridView.count(
            padding: EdgeInsets.only(left: 10.0, right: 10.0),
            crossAxisCount: 1,
            crossAxisSpacing: 4.0,
            mainAxisSpacing: 4.0,
            primary: false,
            shrinkWrap: true,
            children: userData.map((element) {
              return buildResultCard(element);
            }).toList()),
      ),
    );
  }
}

Widget buildResultCard(data) {
  return Card(
    margin: EdgeInsets.all(0.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    elevation: 3.5,
    color: Colors.lightBlueAccent,
    child: Container(
      child: Center(
        child: Text(
          'Name : ${data['name']}\n\nEmail Address : ${data['email']}\n\nDepartment : ${data['department']}\n\nMobile Number : +91 ${data['mobile no']}',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
          ),
        ),
      ),
    ),
  );
}
