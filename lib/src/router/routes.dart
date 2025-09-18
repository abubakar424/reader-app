import 'dart:io';

import 'package:flutter/material.dart';
import '../features/auth/create_pin/pages/create_new_pin.dart';
import '../features/auth/create_pin/pages/enter_new_password.dart';
import '../features/auth/forget/pages/forget_page.dart';
import '../features/auth/login/pages/login_page.dart';
import '../features/auth/sign_up/pages/sign_up_page.dart';
import '../features/bottom_nav/pages/bottom_nav.dart';
import '../features/feedback/pages/feedback_page.dart';
import '../features/on_boarding_screen/pages/onboarding_screen.dart';
import '../features/pdf_viewer/pdf_viewerScreen.dart';
import '../features/profile/pages/profile_edit/edit_profile.dart';
import '../features/profile/pages/profile_update.dart';
import '../features/profile/pages/settings/settings_screen.dart';
import '../features/scan/pages/appointments.dart';
import '../features/scan/pages/choose_language.dart';
import '../features/scan/pages/document_preview.dart';
import 'package:go_router/go_router.dart';
import '../features/scan/pages/scan_page.dart';
import 'error_route.dart';
import 'route_transition.dart';

class MyAppRouter {
  static final router = GoRouter(
    initialLocation: '/${AppRoute.onboardingScreen}',
    routes: [
      GoRoute(
        name: AppRoute.onboardingScreen,
        path: '/${AppRoute.onboardingScreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const OnBoardingScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.bottomNav,
        path: '/${AppRoute.bottomNav}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: BottomNav(),
        ),
      ),

      //! profile Section !!!!
      GoRoute(
        name: AppRoute.profilescreen,
        path: '/${AppRoute.profilescreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ProfileUipdate(),
        ),
      ),
      GoRoute(
        name: AppRoute.editprofile,
        path: '/${AppRoute.editprofile}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const EditProfile(),
        ),
      ),
      GoRoute(
        name: AppRoute.settingscreen,
        path: '/${AppRoute.settingscreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: SettingsScreen(),
        ),
      ),

      GoRoute(
        path: '/${AppRoute.appointmentPage}',
        name: AppRoute.appointmentPage,
        builder: (context, state) {
          final documentPath = state.extra as String;
          return AppointmentPage(documentPath: documentPath);
        },
      ),
      GoRoute(
        name: AppRoute.filesPage,
        path: '/${AppRoute.filesPage}',
        pageBuilder: (context, state) {
          // Assuming the file path or File object is passed via state.extra
          final File file = state.extra as File; // Adjust based on how you pass the file
          return buildPageWithFadeTransition<void>(
            context: context,
            state: state,
            child: Image(image: FileImage(file)), // Wrap FileImage in an Image widget
          );
        },
      ),
      GoRoute(
        path: '/${AppRoute.documentPreviewPage}',
        name: AppRoute.documentPreviewPage,
        builder: (context, state) {
          final documentPath = state.extra as String;
          return DocumentPreviewPage(documentPath: documentPath);
        },
      ),

      GoRoute(
        name: AppRoute.loginPage,
        path: '/${AppRoute.loginPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const LoginPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.singUpPage,
        path: '/${AppRoute.singUpPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const SignUpPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.forgetPage,
        path: '/${AppRoute.forgetPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: ForgetPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.createPinPage,
        path: '/${AppRoute.createPinPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: CreateNewPinPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.enterNewPasswordPage,
        path: '/${AppRoute.enterNewPasswordPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const EnterNewPasswordPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.chooseLanguage,
        path: '/${AppRoute.chooseLanguage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ChooseLanguage(),
        ),
      ),
      GoRoute(
        name: AppRoute.scanPage,
        path: '/${AppRoute.scanPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: const ScanPage(),
        ),
      ),

      GoRoute(
        name: AppRoute.feedbackPage,
        path: '/${AppRoute.feedbackPage}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: FeedbackPage(),
        ),
      ),
      GoRoute(
        name: AppRoute.pdfViewerScreen,
        path: '/${AppRoute.pdfViewerScreen}',
        pageBuilder: (context, state) => buildPageWithFadeTransition<void>(
          context: context,
          state: state,
          child: PdfViewerscreen(),
        ),
      )
    ],
    errorPageBuilder: (context, state) {
      return const MaterialPage(child: ErrorPage());
    },
  );

  static void clearAndNavigate(BuildContext context, String name) {
    while (context.canPop()) {
      context.pop();
    }
    context.pushReplacementNamed(name);
  }
}

class AppRoute {
  static const String errorPage = 'error-page';
  static const String home = 'home';
  // bottom_nav
  static const String bottomNav = 'bottom-nav';
  static const String homePage = 'home-page';
  static const String chooseLanguage = 'choose-language';
  static const String documentPreviewPage = 'document-preview-page';
  static const String onboardingScreen = 'onboarding_screen';

  //! profile Section

  static const String profilescreen = 'profile';
  static const String editprofile = 'profile-edit';
  static const String settingscreen = 'settings';

  // bottom_nav
  static const String appointmentPage = 'appointment-page';
  static const String filesPage = 'files-page';
  static const String loginPage = 'login-page';
  static const String singUpPage = 'sign-up-page';
  static const String forgetPage = 'forget-up-page';
  static const String createPinPage = 'create-pin-page';
  static const String enterNewPasswordPage = 'enter-new-password-page';
  static const String scanPage = 'scan-page';
  static const String feedbackPage = 'feedback-page';
  static const String pdfViewerScreen = 'PdfViewerScreen';
}
