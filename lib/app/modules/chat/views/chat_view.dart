import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kgchat/app/app_constants/colors/app_colors.dart';
import 'package:kgchat/app/app_constants/decorations/app_decorations.dart';
import 'package:kgchat/app/app_constants/text_styles/app_text_styles.dart';
import 'package:kgchat/app/app_widgets/chats/stream_chats.dart';
import 'package:kgchat/app/data/models/chats/chat_model.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/modules/chat/bloc/chat_bloc.dart';

///bLoc version
class ChatView extends StatefulWidget {
  final UserModel? talkingToUser;
  final UserModel? currentUser;

  const ChatView({Key? key, this.talkingToUser, this.currentUser})
      : super(key: key);
  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  late final ChatBloc _chatBloc;

  final _messageTextController = TextEditingController();

  @override
  void initState() {
    _chatBloc = context.read<ChatBloc>();

    _chatBloc
      ..add(SetUsersEvent(widget.currentUser!, widget.talkingToUser!))
      ..add(StartChatsStreamEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log('ChatView.build.....');
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        iconTheme: IconThemeData(color: AppColors.black),
        title: Text(
          'Chat',
          style: AppTextStyles.mulishBlack18w600,
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamChats(
                currentUser: widget.currentUser!,
                talkingToId: widget.talkingToUser!.userID!),
            Container(
              decoration: AppDecorations.messageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageTextController,
                      onChanged: (value) {
                        // messageText = value;
                      },
                      decoration: AppDecorations.messageTextFieldDecoration,
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_messageTextController.text.isNotEmpty) {
                        ChatModel _chatModel = ChatModel(
                          text: _messageTextController.text,
                          senderID: widget.currentUser!.userID,
                          senderName: widget.currentUser!.name,
                          senderLastname: widget.currentUser!.lastName,
                          senderAvatar: widget.currentUser!.profilePhoto,
                          senderPhone: widget.currentUser!.phone,
                          recieverID: widget.talkingToUser!.userID,
                          recieverName: widget.talkingToUser!.name,
                          recieverLastname: widget.talkingToUser!.lastName,
                          recieverAvatar: widget.talkingToUser!.profilePhoto,
                          recieverPhone: widget.talkingToUser!.phone,
                        );

                        _chatBloc.add(SendMessangeEvent(_chatModel));

                        _messageTextController.clear();
                      }
                    },
                    child: Text(
                      'Send',
                      style: AppTextStyles.sendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}



///GetX version
// class ChatView extends StatefulWidget {
//   @override
//   State<ChatView> createState() => _ChatViewState();
// }

// class _ChatViewState extends State<ChatView> {
//   final ChatController _chatcontroller = ChatController.findChatCont;

//   final _messageTextController = TextEditingController();

//   final AuthenticationController _authCont =
//       AuthenticationController.findAuthCont!;

//   @override
//   void initState() {
//     final _talkingToUser = Get.arguments as UserModel;

//     _chatcontroller.setUsers(_authCont.getCurrentUser, _talkingToUser);

//     _chatcontroller.bindChatStream();

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         iconTheme: IconThemeData(color: AppColors.black),
//         title: Text(
//           'Chat',
//           style: AppTextStyles.mulishBlack18w600,
//         ),
//       ),
//       body: SafeArea(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           crossAxisAlignment: CrossAxisAlignment.stretch,
//           children: <Widget>[
//             StreamChats(),
//             Container(
//               decoration: AppDecorations.messageContainerDecoration,
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: <Widget>[
//                   Expanded(
//                     child: TextField(
//                       controller: _messageTextController,
//                       onChanged: (value) {
//                         // messageText = value;
//                       },
//                       decoration: AppDecorations.messageTextFieldDecoration,
//                     ),
//                   ),
//                   TextButton(
//                     onPressed: () async {
//                       if (_messageTextController.text.isNotEmpty) {
//                         ChatModel _chatModel = ChatModel(
//                           text: _messageTextController.text,
//                           senderID: _chatcontroller.currentUser.value.userID,
//                           senderName: _chatcontroller.currentUser.value.name,
//                           senderLastname:
//                               _chatcontroller.currentUser.value.lastName,
//                           senderAvatar:
//                               _chatcontroller.currentUser.value.profilePhoto,
//                           senderPhone: _chatcontroller.currentUser.value.phone,
//                           recieverID:
//                               _chatcontroller.talkingToUser.value.userID,
//                           recieverName:
//                               _chatcontroller.talkingToUser.value.name,
//                           recieverLastname:
//                               _chatcontroller.talkingToUser.value.lastName,
//                           recieverAvatar:
//                               _chatcontroller.talkingToUser.value.profilePhoto,
//                           recieverPhone:
//                               _chatcontroller.talkingToUser.value.phone,
//                         );

//                         await _chatcontroller.sendMessage(_chatModel);

//                         _messageTextController.clear();
//                       }
//                     },
//                     child: Text(
//                       'Send',
//                       style: AppTextStyles.sendButtonTextStyle,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
