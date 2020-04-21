import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore = Firestore.instance;

class CrudMethods {
  final db = Firestore.instance;

  bool isLoggedIn() {
    if (FirebaseAuth.instance.currentUser() != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<void> addData(id, carData) async {
    if (isLoggedIn()) {
      Firestore.instance
          .collection('Library books')
          .document(id)
          .updateData({'status': true}).catchError((e) {
        print(e);
      });

      //db.collection("Issue").where('book_id',isEqualTo:'book').snapshots();

      db.collection("Issue").document(id).setData(carData).catchError((e) {
        print(e);
      });
    } else {
      print('You need to be logged in');
    }
  }

  getData() async {
    return await Firestore.instance.collection('Issue').snapshots();
  }

  updateData(selectedDoc, newValues) {
    Firestore.instance
        .collection('Issue')
        .document(selectedDoc)
        .updateData(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    Firestore.instance
        .collection('Issue')
        .document(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
