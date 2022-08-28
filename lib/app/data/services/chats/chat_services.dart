import 'package:kgchat/app/data/models/chats/chat_model.dart';
import 'package:kgchat/app/data/services/firestore/firestore_services.dart';

class ChatServices {
  Future<void> sendMessage(ChatModel chatModel) async {
    await firestoreServices.sendMessage(chatModel);
  }

  Stream<List<ChatModel>>? streamMessages(
    String? currentUserId,
    String? talkingToUserId,
  ) {
    return firestoreServices.streamMessages(currentUserId, talkingToUserId);
  }
}

final ChatServices chatServices = ChatServices();
