import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgchat/app/app_widgets/chats/message_bubble.dart';
import 'package:kgchat/app/app_widgets/progress/progress.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/modules/chat/bloc/chat_bloc.dart';

class StreamChats extends StatelessWidget {
  final UserModel currentUser;
  final String talkingToId;

  StreamChats({
    required this.currentUser,
    required this.talkingToId,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    log('StreamChats.build.....');
    return BlocBuilder<ChatBloc, ChatState>(
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        log('StreamChats.BlocBuilder.build.....');

        if (state is ChatLoading) {
          return Center(child: circularProgress());
        }

        if (state is ChatLoaded) {
          if (state.chats.isEmpty) {
            return Expanded(
              child: const Center(child: Text('No chats available!')),
            );
          } else {
            return Expanded(
              child: ListView.builder(
                reverse: true,
                itemCount: state.chats.length,
                itemBuilder: (context, index) {
                  final _chat = state.chats[index];

                  return MessageBubble(
                    isMe: _chat.senderID == currentUser.userID,
                    sender: _chat.senderName,
                    text: _chat.text,
                  );
                },
              ),
            );

            /// eski kod
            // List<MessageBubble> _chatWidgets = <MessageBubble>[];

            // for (final _chat in state.chats) {
            //   MessageBubble _chatWidget = MessageBubble(
            //     isMe: _chat.senderID == currentUser.userID,
            //     sender: _chat.senderName,
            //     text: _chat.text,
            //   );

            //   _chatWidgets.add(_chatWidget);
            // }

            // return Expanded(
            //   child: ListView(
            //     reverse: true,
            //     padding: const EdgeInsets.symmetric(
            //         horizontal: 10.0, vertical: 20.0),
            //     children: _chatWidgets,
            //   ),
            // );
          }
        }
        return Expanded(child: const Center(child: Text('No data available!')));
      },
    );
  }
}



///GetX version
// class StreamChats extends StatelessWidget {
//   StreamChats({
//     Key? key,
//   }) : super(key: key);

//   final ChatController _chatController = ChatController.findChatCont;

//   @override
//   Widget build(BuildContext context) {
//     return Obx(
//       () {
//         if (_chatController.isLoading.value) {
//           return Center(child: circularProgress());
//         } else if (_chatController.chats.isNotEmpty) {
//           List<MessageBubble> _chatWidgets = <MessageBubble>[];

//           for (final _chat in _chatController.chats) {
//             MessageBubble _chatWidget = MessageBubble(
//               isMe: _chat.senderID == _chatController.currentUser.value.userID,
//               sender: _chat.senderName,
//               text: _chat.text,
//             );

//             _chatWidgets.add(_chatWidget);
//           }

//           return Expanded(
//             child: ListView(
//               reverse: true,
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
//               children: _chatWidgets,
//             ),
//           );
//         } else {
//           return const Center(child: Text('No chats available!'));
//         }
//       },
//     );
//   }
// }
