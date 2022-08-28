import 'package:get/get.dart';
import 'package:kgchat/app/data/models/chats/chat_model.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/domain/repos/chats/chat_repo.dart';

class ChatController extends GetxController {
  static final ChatController findChatCont = Get.find<ChatController>();
  Rx<UserModel> currentUser = UserModel().obs;
  Rx<UserModel> talkingToUser = UserModel().obs;

  RxList<ChatModel> chats = <ChatModel>[].obs;

  RxBool isLoading = false.obs;

  void setUsers(UserModel _currentUser, UserModel _talkingToUser) {
    setIsLoading(true);
    currentUser.value = _currentUser;
    talkingToUser.value = _talkingToUser;
    setIsLoading(false);
  }

  void setIsLoading(bool val) {
    isLoading.value = val;
    update();
  }

  Future<void> sendMessage(ChatModel chatModel) async {
    await chatRepo.sendMessage(chatModel);
  }

  void bindChatStream() {
    chats.bindStream(streamMessages()!);
  }

  Stream<List<ChatModel>>? streamMessages() {
    return chatRepo.streamMessages(
        currentUser.value.userID, talkingToUser.value.userID);
  }
}
