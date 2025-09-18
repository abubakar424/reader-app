import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/global_variables.dart';
import '../../../../router/routes.dart';
import '../../../bottom_nav/widget/controller.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isNotificationsEnabled = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Consumer<btmBarProvider>(
          builder: (context, value, child) => IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (value.currentIndex == 3) {
                value.setIndex(0);
                globalPersistentTabController.index = 0;
              }
              Navigator.pop(context);
            },
          ),
        ),
        title: Text(
          "Settings",
          style: textTheme(context)
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildSwitchTile("Notifications", isNotificationsEnabled),
            SizedBox(
              height: 15,
            ),
            customText("Scan setting", onTap: () {
              context.pushNamed(AppRoute.scanPage);
            }),
            customText("Privacy policy", onTap: () {}),
            customText("Help", onTap: () {}),
            customText("Sync", onTap: () {}),
            customText("About", onTap: () {}),
          ],
        ),
      ),
    );
  }

  Widget buildSwitchTile(String title, bool value) {
    return Container(
      padding: EdgeInsets.all(5),
      width: double.infinity,
      decoration: BoxDecoration(
          border: Border.all(color: AppColor.appgrey.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: EdgeInsets.only(left: 30),
        title: Text(
          title,
          style: textTheme(context)
              .bodyLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        trailing: Switch(
          value: value,
          activeColor: Colors.red,
          onChanged: (val) {
            setState(() {
              isNotificationsEnabled = val;
            });
          },
        ),
      ),
    );
  }

  Widget customText(String title, {required VoidCallback onTap}) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          // padding: EdgeInsets.all(5),
          width: double.infinity,
          decoration: BoxDecoration(
              border: Border.all(color: AppColor.appgrey.withOpacity(0.2)),
              borderRadius: BorderRadius.circular(12)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20, left: 30),
                child: Text(
                  title,
                  style: textTheme(context)
                      .bodyLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
