import 'package:cloud_firestore/cloud_firestore.dart';

final firestore = Firestore.instance;

class SearchService {
  searchByName(String searchField) {
    return firestore
        .collection('Library books')
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .getDocuments();
  }
}
