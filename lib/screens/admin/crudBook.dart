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

      db.collection("Library books").document(id).setData(carData).catchError((e){
        print(e);
      });
    } else {
      print('You need to be logged in');
    }
  }

  getData() async {
    return await Firestore.instance.collection('Library books').snapshots();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('Library books')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('Library books')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}