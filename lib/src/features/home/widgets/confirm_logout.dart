import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../router/routes.dart';
import 'custom_logout_button.dart';

class ConfirmLogout extends StatefulWidget {
  const ConfirmLogout({super.key});

  @override
  State<ConfirmLogout> createState() => _ConfirmLogoutState();
}

class _ConfirmLogoutState extends State<ConfirmLogout> {
  bool isLogoutPressed = false;
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                height: 40,
                width: 40,
                decoration: BoxDecoration(
                  color: Color(0xff1FA76A),
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: Icon(Icons.close, color: colorScheme(context).surface),
                  onPressed: () {
                    context.pop();
                  },
                ),
              ),
            ),
            Text(
              'Log out',
              style: textTheme(context)
                  .headlineSmall
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16.0),
            SizedBox(
              height: 133,
              width: 133,
              child: SvgPicture.asset(
                AppIcons.like,
                width: 75,
                height: 70,
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              'You have \nsuccessfully log out',
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomLogoutButton(
                  height: 47,
                  width: 200,
                  ontab: () {
                    setState(() {
                      isLogoutPressed = !isLogoutPressed;
                    });
                    Future.delayed(const Duration(milliseconds: 500), () {
                      context.pushNamed(AppRoute.loginPage);
                    });
                  },
                  decorationcolor: isLogoutPressed
                      ? colorScheme(context).primary
                      : colorScheme(context).onPrimary,
                  bordercolor: colorScheme(context).primary,
                  text: "Back to Login",
                  textcolor: isLogoutPressed
                      ? colorScheme(context).onPrimary
                      : colorScheme(context).primary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
