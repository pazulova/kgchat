import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:kgchat/app/data/models/chats/chat_model.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/domain/repos/chats/chat_repo.dart';
import 'package:kgchat/app/utils/di_locator/di_locator.dart';

part 'chat_event.dart';
part 'chat_state.dart';

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepo _chatRepo;

  ChatBloc()
      : _chatRepo = getIt<ChatRepo>(),
        super(ChatLoading()) {
    on<SetUsersEvent>(_setUsers);
    on<SendMessangeEvent>(_sendMessage);
    on<StartChatsStreamEvent>(_startStreamChats);
  }

  UserModel? _currentUser;
  UserModel? _talkingToUser;

  void _setUsers(SetUsersEvent event, Emitter<ChatState> emit) {
    _currentUser = event.currentUser;
    _talkingToUser = event.talkingToUser;

    emit(UsersSet());
  }

  Future<void> _sendMessage(
      SendMessangeEvent event, Emitter<ChatState> emit) async {
    await _chatRepo.sendMessage(event.chatModel);
  }

  FutureOr<void> _startStreamChats(
      StartChatsStreamEvent event, Emitter<ChatState> emit) async {
    await emit.forEach<List<ChatModel>>(
      _chatRepo.streamMessages(_currentUser!.userID!, _talkingToUser!.userID)!,
      onData: (chats) => ChatLoaded(chats),
      onError: (err, stackTrace) => ChatError('Something went wrong!'),
    );
  }
}
