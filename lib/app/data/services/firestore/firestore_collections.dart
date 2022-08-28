import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreCollections {
  static FirestoreCollections? _firestoreCollections;
  static late FirebaseFirestore _firestore;

  static FirestoreCollections getInstance() {
    if (_firestoreCollections == null) {
      final firestoreCollections = FirestoreCollections._();
      firestoreCollections._init();
      _firestoreCollections = firestoreCollections;
    }
    return _firestoreCollections!;
  }

  FirestoreCollections._();

  void _init() {
    _firestore = FirebaseFirestore.instance;
  }

  static final CollectionReference usersCollections =
      _firestore.collection("users");
  static final CollectionReference chatsCollections =
      _firestore.collection("chats");
  static final CollectionReference messagesCollections =
      _firestore.collection("messages");
}
