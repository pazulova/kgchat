import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:kgchat/app/app_constants/colors/app_colors.dart';

class CircleProfileWidget extends StatelessWidget {
  const CircleProfileWidget({
    required this.onTap,
    this.imageUrl,
    Key? key,
  }) : super(key: key);

  final VoidCallback onTap;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(100.0),
      decoration:
          BoxDecoration(color: AppColors.greyDarker, shape: BoxShape.circle),
      child: Stack(
        children: [
          if (imageUrl!.isNotEmpty)
            CircleAvatar(
              radius: 60,
              backgroundImage: NetworkImage(imageUrl!),
            )
          else
            Padding(
              padding: const EdgeInsets.all(34.0),
              child: FaIcon(
                FontAwesomeIcons.user,
                size: 60,
              ),
            ),
          Positioned(
            bottom: 3,
            right: 2,
            child: InkWell(
              onTap: onTap,
              child: FaIcon(
                FontAwesomeIcons.plusCircle,
                size: 30,
                color: imageUrl!.isNotEmpty
                    ? AppColors.mainColor
                    : AppColors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
