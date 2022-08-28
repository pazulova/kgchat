import 'package:flutter/material.dart';
import 'package:kgchat/app/data/models/user/user_model.dart';
import 'package:kgchat/app/utils/text_utils/masking_string_util.dart';

class SingleUserContactTile extends StatelessWidget {
  final GestureTapCallback? onTap;
  final UserModel? user;
  const SingleUserContactTile({
    required this.onTap,
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: ListTile(
        title: Text(user!.name!),
        subtitle: Text(user!.phone!.isNotEmpty
            ? MaskingStringUtil.maskingPhoneNumber(user!.phone!)
            : '(none)'),
        trailing: user!.isRegistered!
            ? Icon(
                Icons.verified_user,
                color: Colors.green,
              )
            : Icon(Icons.close, color: Colors.red),
        leading: CircleAvatar(
          child: Text(user!.name!.substring(0, 1)),
          //  user.profilePhoto!.isNotEmpty
          //     ? Image.network(user.profilePhoto!)
          //     : Text(user.name!.substring(0, 1)),
        ),
      ),
    );
  }
}
