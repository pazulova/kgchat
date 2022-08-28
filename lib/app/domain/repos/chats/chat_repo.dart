import 'package:kgchat/app/data/models/chats/chat_model.dart';
import 'package:kgchat/app/data/services/chats/chat_services.dart';

class ChatRepo {
  Future<void> sendMessage(ChatModel chatModel) async {
    await chatServices.sendMessage(chatModel);
  }

  Stream<List<ChatModel>>? streamMessages(
    String? _currentUserId,
    String? _talkingToUserId,
  ) {
    return chatServices.streamMessages(_currentUserId, _talkingToUserId);
  }
}

final ChatRepo chatRepo = ChatRepo();
