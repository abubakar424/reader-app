import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:provider/provider.dart';
import 'package:reader_app/src/features/auth/login/provider/check_box_provider.dart';
import 'package:reader_app/src/features/bottom_nav/widget/controller.dart';
import 'package:reader_app/src/features/feedback/provider/expanded_provider.dart';
import 'package:reader_app/src/features/profile/provider/provider1.dart';
import '/src/common/utils/shared_preference_helper.dart';
import 'src/common/constants/global_variables.dart';
import 'src/features/home/provider/document.dart';
import 'src/router/routes.dart';
import 'src/theme/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefHelper.getInitialValue();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => btmBarProvider()),
        ChangeNotifierProvider(create: (context) => DocumentProvider()),
        ChangeNotifierProvider(create: (context) => CheckBoxProvider()),
        ChangeNotifierProvider(create: (context) => ExpandProvider(2)),
        ChangeNotifierProvider(create: (context) => ImageProviderNotifier()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GlobalLoaderOverlay(
      child: MaterialApp.router(
        locale: DevicePreview.locale(context),
        title: 'Basic Structure',
        debugShowCheckedModeBanner: false,
        scaffoldMessengerKey: scaffoldMessengerKey,
        theme: AppTheme.instance.lightTheme,
        darkTheme: AppTheme.instance.darkTheme,
        themeMode: ThemeMode.light,
        routerDelegate: MyAppRouter.router.routerDelegate,
        routeInformationParser: MyAppRouter.router.routeInformationParser,
        routeInformationProvider: MyAppRouter.router.routeInformationProvider,
      ),
    );
  }
}
