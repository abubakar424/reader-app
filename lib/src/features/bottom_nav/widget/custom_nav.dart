import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../common/constants/app_colors.dart';

class CustomNavBarIcon extends StatelessWidget {
  final bool isActive;
  final String activeIconPath;
  final String inactiveIconPath;
  final bool isFeedbackIcon;
  final Color? inActiveIconColor;

  const CustomNavBarIcon({
    Key? key,
    required this.isActive,
    required this.activeIconPath,
    required this.inactiveIconPath,
    this.isFeedbackIcon = false,
    this.inActiveIconColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: isActive && isFeedbackIcon ? 1.3 : 1.3,
      child: isActive
          ? SvgPicture.asset(
              activeIconPath,
              fit: BoxFit.contain,
              color: AppColor.appBrown,
            )
          : Image.asset(
              inactiveIconPath,
              fit: BoxFit.contain,
              color: inActiveIconColor,
            ),
    );
  }
}
