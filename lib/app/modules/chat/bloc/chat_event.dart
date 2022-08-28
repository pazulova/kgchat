part of 'chat_bloc.dart';

abstract class ChatEvent extends Equatable {
  const ChatEvent();

  @override
  List<Object> get props => [];
}

class SetUsersEvent extends ChatEvent {
  final UserModel currentUser;
  final UserModel talkingToUser;

  SetUsersEvent(this.currentUser, this.talkingToUser);

  @override
  List<Object> get props => [
        currentUser,
        talkingToUser,
      ];
}

class SendMessangeEvent extends ChatEvent {
  final ChatModel chatModel;

  SendMessangeEvent(this.chatModel);

  @override
  List<Object> get props => [chatModel];
}

class StartChatsStreamEvent extends ChatEvent {}

class StreamChatsEvent extends ChatEvent {
  final List<ChatModel> chats;

  StreamChatsEvent(this.chats);

  @override
  List<Object> get props => [chats];
}
