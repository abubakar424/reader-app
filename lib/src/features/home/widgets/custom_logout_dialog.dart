import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/constants/app_colors.dart' show AppColor;
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../router/routes.dart';
import 'confirm_logout.dart';
import 'custom_logout_button.dart';

class CustomLogoutDialog extends StatefulWidget {
  const CustomLogoutDialog({super.key});

  @override
  State<CustomLogoutDialog> createState() => _CustomLogoutDialogState();
}

class _CustomLogoutDialogState extends State<CustomLogoutDialog> {
  bool isCancelPressed = false;
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
            Container(
              height: 133,
              width: 133,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.out))),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Are you sure you want \nto log out',
              textAlign: TextAlign.center,
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(color: AppColor.appgrey),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomLogoutButton(
                  height: 47,
                  width: 120,
                  ontab: () {
                    setState(() {
                      isCancelPressed = !isCancelPressed;
                      isLogoutPressed = false;
                    });
                    Future.delayed(const Duration(milliseconds: 500), () {
                      context.pop();
                    });
                  },
                  decorationcolor: isCancelPressed
                      ? AppColor.appGreen
                      : colorScheme(context).onPrimary,
                  bordercolor: AppColor.appGreen,
                  text: "cancel",
                  textcolor: isCancelPressed
                      ? colorScheme(context).onPrimary
                      : AppColor.appGreen,
                ),
                CustomLogoutButton(
                  height: 47,
                  width: 120,
                  ontab: () {
                    setState(() {
                      isLogoutPressed = !isLogoutPressed;
                      isCancelPressed = false;
                    });
                    Future.delayed(const Duration(milliseconds: 500), () {
                      context.pop();
                      showDialog(
                        context: context,
                        builder: (context) {
                          return const ConfirmLogout();
                        },
                      );
                    });
                  },
                  decorationcolor: isLogoutPressed
                      ? colorScheme(context).primary
                      : colorScheme(context).onPrimary,
                  bordercolor: colorScheme(context).primary,
                  text: "yes,logout",
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

// This is the new confirmation dialog that shows after logout confirmation
class CustomLogoutConfirmationDialog extends StatelessWidget {
  const CustomLogoutConfirmationDialog({Key? key}) : super(key: key);

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
                    color: AppColor.appGreen,
                    borderRadius: BorderRadius.circular(30)),
                child: IconButton(
                  icon: Icon(Icons.close, color: colorScheme(context).surface),
                  onPressed: () {
                    Navigator.of(context).pop(); // Close the dialog
                  },
                ),
              ),
            ),
            // Title
            Text(
              'Log out',
              style: textTheme(context).headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: colorScheme(context).onSurface.withOpacity(0.7)),
            ),
            const SizedBox(height: 16.0),
            Container(
              height: 133,
              width: 133,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(AppImages
                          .thumb))), // Replace with your specific image
            ),
            const SizedBox(height: 16.0),
            Text(
              'You have \nsuccessfully log out.',
              textAlign: TextAlign.center,
              style: textTheme(context)
                  .bodyMedium
                  ?.copyWith(color: AppColor.appgrey),
            ),
            const SizedBox(height: 24.0),

            CustomButton(
              onTap: () {
                context.pushNamed(AppRoute.loginPage);
              },
              height: 47,
              textsize: 12,
              text: "Back to Login",
            ),
          ],
        ),
      ),
    );
  }
}
