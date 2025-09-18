import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../feedback/pages/feedback_page.dart';
import '../../home/pages/home_page.dart';
import '../../profile/pages/settings/settings_screen.dart';
import '../../scan/pages/scan_page.dart';
import '../widget/controller.dart';
import '../widget/custom_nav.dart';

class BottomNav extends StatefulWidget {
  BottomNav({Key? key}) : super(key: key);

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  File? get imageFile => null;

  List<Widget> _buildScreens() {
    return [
      HomePage(),
      Scaffold(
        body: Center(
          child: Image(image: FileImage(imageFile!)),
        ),
      ),
      const ScanPage(),
      const SettingsScreen(),
      const FeedbackPage(),
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        iconSize: 20,
        icon: CustomNavBarIcon(
          isActive: globalPersistentTabController.index == 0,
          activeIconPath: AppIcons.brownhome,
          inactiveIconPath: AppImages.homeIcon,
        ),
        title: "Home",
        textStyle: const TextStyle(fontSize: 12),
        activeColorPrimary: AppColor.appBrown,
        inactiveColorPrimary: AppColor.apppink,
        contentPadding: 0,
      ),
      PersistentBottomNavBarItem(
        iconSize: 20,
        icon: CustomNavBarIcon(
          isActive: globalPersistentTabController.index == 1,
          activeIconPath: AppIcons.brownfile,
          inactiveIconPath: AppImages.fileIcon,
        ),
        title: "Files",
        textStyle: const TextStyle(fontSize: 12),
        activeColorPrimary: AppColor.appBrown,
        inactiveColorPrimary: AppColor.apppink,
        contentPadding: 0,
      ),
      PersistentBottomNavBarItem(
        iconSize: 20,
        icon: Transform.scale(
          scale: 0.4,
          child: Image.asset(AppImages.scan, fit: BoxFit.contain),
        ),
        title: "koko",
        activeColorSecondary: Colors.transparent,
        activeColorPrimary: AppColor.apppink,
        inactiveColorPrimary: Colors.transparent,
        textStyle: const TextStyle(color: Colors.transparent),
        contentPadding: 0,
      ),
      PersistentBottomNavBarItem(
        iconSize: 30,
        icon: Transform.scale(
          scale: 1.3,
          child: Consumer<btmBarProvider>(
            builder: (context, value, child) => SvgPicture.asset(
              AppIcons.setting,
              fit: BoxFit.cover,
              color: value.currentIndex == 3
                  ? AppColor.appBrown
                  : AppColor.apppink,
            ),
          ),
        ),
        title: "Settings",
        textStyle: const TextStyle(fontSize: 12),
        activeColorPrimary: AppColor.appBrown,
        inactiveColorPrimary: AppColor.apppink,
        contentPadding: 10,
        // iconSize: 20,
        // icon: CustomNavBarIcon(
        //   isActive: globalPersistentTabController.index == 3,
        //   activeIconPath: AppIcons.setting,
        //   inactiveIconPath: AppImages.settingsImage,
        //   inActiveIconColor: AppColor.apppink,
        // ),
        // title: "Settings",
        // textStyle: const TextStyle(fontSize: 12),
        // activeColorPrimary: AppColor.appBrown,
        // inactiveColorPrimary: AppColor.apppink,
        // contentPadding: 0,
      ),
      PersistentBottomNavBarItem(
        iconSize: 20,
        icon: CustomNavBarIcon(
          isActive: globalPersistentTabController.index == 4,
          activeIconPath: AppIcons.brownfeedback,
          inactiveIconPath: AppImages.feedback,
          isFeedbackIcon: true,
        ),
        title: "Feedback",
        textStyle: const TextStyle(fontSize: 12),
        activeColorPrimary: AppColor.appBrown,
        inactiveColorPrimary: AppColor.apppink,
        contentPadding: 0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<btmBarProvider>(context);
    return PersistentTabView(
      context,
      controller: globalPersistentTabController,
      screens: _buildScreens(),
      items: _navBarsItems(),
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(vertical: 4),
      confineToSafeArea: true,
      backgroundColor: Colors.white,
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      navBarHeight: 70,
      bottomScreenMargin: 0,
      
      decoration: NavBarDecoration(
        border: Border(
          top: BorderSide(
            color: Theme.of(context).colorScheme.primary.withOpacity(0.5),
            width: 1,
          ),
        ),
      ),
      navBarStyle: NavBarStyle.style15,
      onItemSelected: (index) {
        setState(() {
          globalPersistentTabController.index = index;
          if (index == 3) {
            provider.setIndex(3);
            log('3');
          }
        });
      },
    );
  }
}
