import 'package:flutter/material.dart';

ColorScheme colorScheme(context) => Theme.of(context).colorScheme;

TextTheme textTheme(context) => Theme.of(context).textTheme;

final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

const String isFirstTimeText = 'isFirstTime';
const String isUserText = 'isUser';
const String isLoggedInText = 'isLoggedIn';
const String emailText = 'email';
