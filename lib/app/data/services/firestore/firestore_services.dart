import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kgchat/app/data/models/chats/chat_model.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/data/services/firestore/firestore_collections.dart';

class FirestoreServices {
  Future<bool?>? checkUserExists(String? userID) async {
    DocumentSnapshot? _getUser =
        await FirestoreCollections.usersCollections.doc(userID).get();
    return _getUser.exists;
  }

  Future<UserModel> getUser(String userID) async {
    DocumentSnapshot _getUser =
        await FirestoreCollections.usersCollections.doc(userID).get();

    if (_getUser.exists) {
      final _getUserMap = _getUser.data() as Map<String, dynamic>;

      UserModel _getUserObject = UserModel.fromJson(_getUserMap);

      return _getUserObject;
    } else {
      return UserModel();
    }
  }

  Future<bool> saveUserToFirestore(UserModel user) async {
    return await FirestoreCollections.usersCollections
        .doc(user.userID)
        .set(user.toJson(), SetOptions(merge: true))
        .then((value) => true)
        .onError((error, stackTrace) => false);
  }

  Future<List<UserModel>> getUsers() async {
    List<UserModel> _users = <UserModel>[];
    final _response = await FirestoreCollections.usersCollections.get();

    for (final doc in _response.docs) {
      final _userModel = UserModel.fromJson(doc.data() as Map<String, dynamic>);

      _users.add(_userModel);
    }

    return _users;
  }

  Future<void> sendMessage(ChatModel chatModel) async {
    final _senderID = chatModel.senderID;
    final _recieverID = chatModel.recieverID;

    /// menin chattar koshuldu
    await FirestoreCollections.chatsCollections
        .doc(_senderID)
        .collection('messages')
        .doc(_recieverID)
        .collection('message')
        .add(chatModel.toJson());

    /// men suyloshup atkan adamga chattardi koshtuk
    await FirestoreCollections.chatsCollections
        .doc(_recieverID)
        .collection('messages')
        .doc(_senderID)
        .collection('message')
        .add(chatModel.toJson());
  }

  Stream<List<ChatModel>>? streamMessages(
      String? currentUserId, String? talkingToUserId) {
    final _querySnap = FirestoreCollections.chatsCollections
        .doc(currentUserId)
        .collection('messages')
        .doc(talkingToUserId)
        .collection('message')
        .orderBy('createdAt', descending: false)
        .snapshots();

    return _querySnap.map((snapshot) {
      final _queryDocSnapList = snapshot.docs.reversed;
      List<ChatModel> _chats = <ChatModel>[];

      for (final _queryDoc in _queryDocSnapList) {
        if (_queryDoc.exists) {
          ChatModel _chatModel = ChatModel.fromJson(_queryDoc.data());
          _chats.add(_chatModel);
        }
      }

      return _chats;
    });
  }
}

final FirestoreServices firestoreServices = FirestoreServices();
