import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:kgchat/app/app_constants/colors/app_colors.dart';
import 'package:kgchat/app/app_constants/text_styles/app_text_styles.dart';
import 'package:kgchat/app/app_widgets/contacts/single_user_contact_tile.dart';
import 'package:kgchat/app/app_widgets/progress/progress.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/modules/chat/bloc/chat_bloc.dart';
import 'package:kgchat/app/modules/chat/controllers/chat_controller.dart';
import 'package:kgchat/app/modules/chat/views/chat_view.dart';
import 'package:kgchat/app/modules/contacts/bloc/contacts_bloc.dart';
import 'package:kgchat/app/utils/geolocation_utils/permissions_util.dart';

// import '../controllers/contacts_controller.dart';

///bLoc version
class ContactsView extends StatefulWidget {
  final UserModel? currentUser;

  const ContactsView({
    required this.currentUser,
    Key? key,
  }) : super(key: key);
  @override
  State<ContactsView> createState() => _ContactsViewState();
}

class _ContactsViewState extends State<ContactsView> {
  late final ContactsBloc _contactsBloc;

  @override
  void initState() {
    _contactsBloc = context.read<ContactsBloc>();

    _contactsBloc.add(AskPermissionEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        backgroundColor: AppColors.white,
        elevation: 0,
        title: Text(
          'Contacts',
          style: AppTextStyles.mulishBlack18w600,
        ),
        actions: [
          Icon(
            Icons.add,
            color: AppColors.black,
            size: 22,
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: BlocConsumer<ContactsBloc, ContactsState>(
        bloc: _contactsBloc,
        listener: (context, state) {
          if (state is ContactsPermissionGranted) {
            _contactsBloc.add(GetContactsEvent(widget.currentUser!));
          }

          if (state is ContactsPermissionDenied) {
            PermissionsUtil.handleInvalidPermissions(state.permissionStatus!);
          }
        },
        builder: (context, state) {
          if (state is ContactsLoading) {
            return circularProgress();
          }

          if (state is ContactsLoaded) {
            if (state.users!.isEmpty) {
              return Center(
                child: Text('No users available'),
              );
            } else {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: state.users!.length,
                itemBuilder: (context, index) {
                  final _user = state.users![index];

                  return SingleUserContactTile(
                    onTap: () {
                      if (_user.isRegistered!) {
                        Get.lazyPut(() => ChatController());
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BlocProvider(
                              create: (context) => ChatBloc(),
                              child: ChatView(
                                talkingToUser: _user,
                                currentUser: widget.currentUser,
                              ),
                            ),
                          ),
                        );
                        // Get.toNamed(Routes.CHAT, arguments: _user);
                      } else {
                        ///TODO: Invite your friend to the chat
                      }
                    },
                    user: _user,
                  );
                },
              );
            }
          }

          return Center(
            child: Text('No data available!'),
          );
        },
      ),
    );
  }
}


///GetX version
// class ContactsView extends GetView<ContactsController> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.white,
//         elevation: 0,
//         title: Text(
//           'Contacts',
//           style: AppTextStyles.mulishBlack18w600,
//         ),
//         actions: [
//           Icon(
//             Icons.add,
//             color: AppColors.black,
//             size: 22,
//           ),
//           const SizedBox(width: 10),
//         ],
//       ),
//       body: Obx(
//         () => controller.isLoading.value
//             ? circularProgress()
//             : controller.users.isEmpty
//                 ? Center(
//                     child: Text('No users available'),
//                   )
//                 : ListView.builder(
//                     shrinkWrap: true,
//                     itemCount: controller.users.length,
//                     itemBuilder: (context, index) {
//                       final _user = controller.users[index];
//                       // log(' _user.profilePhoto ==>> ${_user.profilePhoto}');

//                       return SingleUserContactTile(
//                         onTap: () {
//                           if (_user.isRegistered!) {
//                             Get.toNamed(Routes.CHAT, arguments: _user);
//                           } else {
//                             ///TODO: Invite your friend to the chat
//                           }
//                         },
//                         user: _user,
//                       );
//                     },
//                   ),
//       ),
//     );
//   }
// }
