import 'dart:io';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../../../router/routes.dart';
import '../../profile/provider/provider1.dart';
import 'custom_logout_dialog.dart';
import 'drawer_custom_row.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ImageProviderNotifier>(context);
    final displayName = (profileProvider.firstName.isNotEmpty ||
            profileProvider.lastName.isNotEmpty)
        ? "${profileProvider.firstName} ${profileProvider.lastName}"
        : "James S. Hernandez";
    final displayImage = profileProvider.selectedImage != null &&
            profileProvider.selectedImage is File
        ? FileImage(profileProvider.selectedImage as File)
        : AssetImage(AppImages.profile);
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 60),
            GestureDetector(
              onTap: () => context.pushNamed(AppRoute.profilescreen),
              child: CircleAvatar(
                  radius: 60,
                  backgroundImage: displayImage as ImageProvider<Object>),
            ),
            const SizedBox(height: 10),
            Text(displayName,
                style: textTheme(context)
                    .headlineMedium
                    ?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 50),
            GestureDetector(
                onTap: () => context.pushNamed(AppRoute.bottomNav),
                child: DrawerCustomRow(icon: AppIcons.home1, text: "Home")),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  context.pushNamed(AppRoute.settingscreen);
                },
                child:
                    DrawerCustomRow(icon: AppIcons.setting, text: "Settings")),
            const SizedBox(height: 20),
            GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const CustomLogoutDialog();
                    },
                  );
                },
                child: DrawerCustomRow(icon: AppIcons.logout, text: "LogOut"))
          ],
        ),
      ),
    );
  }
}
