part of 'chat_bloc.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}

class ChatLoading extends ChatState {}

class UsersSet extends ChatState {}

class ChatLoaded extends ChatState {
  final List<ChatModel> chats;

  ChatLoaded(this.chats);

  @override
  List<Object> get props => [chats];
}

class ChatError extends ChatState {
  final String error;

  ChatError(this.error);

  @override
  List<Object> get props => [error];
}
