import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dart:async';

class crudMedthods {
  //db = Firestore.instance();
  final db = Firestore.instance;



  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(id,carData) async {
    if (isLoggedIn()) {
      db.collection("Users").document(id).setData(carData).catchError((e){
        print(e);
      });
    } else {
      print('You need to be logged in');
    }
  }

  getData() async {
    return await Firestore.instance.collection('Users').snapshots();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('Users')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('Users')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}