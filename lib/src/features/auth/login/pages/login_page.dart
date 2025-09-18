import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_images.dart' show AppIcons;
import '../../../../common/constants/global_variables.dart';
import '../../../../common/utils/validation.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../router/routes.dart';
import '../provider/check_box_provider.dart';

Color txtColor = const Color(0xff545454);

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      Provider.of<CheckBoxProvider>(context, listen: false)
          .onFocusChange(_emailFocusNode.hasFocus);
    });
    _passwordFocusNode.addListener(() {
      Provider.of<CheckBoxProvider>(context, listen: false)
          .onFocusChange(_passwordFocusNode.hasFocus);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Login',
                style: textTheme(context)
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 8,
              ),
              Text(
                'Login to Your Account to Continue your Scans',
                style: textTheme(context)
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500, letterSpacing: 0),
              ),
              const SizedBox(
                height: 20,
              ),
              CustomTextFormField(
                controller: emailController,
                focusNode: _emailFocusNode,
                hint: 'Email',
                hintColor: txtColor,
                hintSize: 14,
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SvgPicture.asset(
                    AppIcons.emailIcon,
                    width: 20,
                    height: 14,
                    fit: BoxFit.contain,
                  ),
                ),
                borderRadius: 100,
                fillColor: Colors.transparent,
                focusBorderColor: colorScheme(context).error,
                borderColor: AppColor.greyColor.withOpacity(0.2),
                validator: (value) => Validation.emailValidation(value),
                onChanged: (value) {
                  context.read<CheckBoxProvider>().onTextChange(value);
                },
              ),
              const SizedBox(
                height: 15,
              ),
              Consumer<CheckBoxProvider>(
                builder: (context, provider, child) {
                  return CustomTextFormField(
                    controller: passwordController,
                    focusNode: _passwordFocusNode,
                    hint: 'Password',
                    hintColor: txtColor,
                    obscureText: provider.isVisible,
                    hintSize: 14,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0), // Adjust as needed
                      child: SvgPicture.asset(
                        AppIcons.passwordIcon,
                        width: 20,
                        height: 14,
                        fit: BoxFit.contain,
                      ),
                    ),
                    borderRadius: 100,
                    fillColor: Colors.transparent,
                    suffixIcon: IconButton(
                      icon: Icon(
                        provider.isVisible
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                        color: colorScheme(context).onSurface,
                      ),
                      onPressed: () {
                        provider.isVisibleChangeValue();
                      },
                    ),
                    focusBorderColor: colorScheme(context).error,
                    borderColor: AppColor.greyColor.withOpacity(0.2),
                    validator: (value) => Validation.passwordValidation(value),
                    onChanged: (value) {
                      context.read<CheckBoxProvider>().onTextChange(value);
                    },
                  );
                },
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Consumer<CheckBoxProvider>(
                    builder: (context, value, child) {
                      return GestureDetector(
                        onTap: () {
                          value.changeValue();
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: colorScheme(context).secondary),
                          child: Container(
                            decoration: BoxDecoration(
                                color: colorScheme(context).onPrimary,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.check,
                              color: value.isCheck
                                  ? colorScheme(context).secondary
                                  : colorScheme(context).onPrimary,
                              size: 14,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(
                    width: 4,
                  ),
                  Text(
                    'Agree to Terms & Conditions',
                    style: textTheme(context).bodySmall!.copyWith(
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0,
                        color: txtColor),
                  ),
                  const Spacer(),
                  GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoute.forgetPage);
                      },
                      child: Text(
                        'Forgot Password?',
                        style: textTheme(context).bodySmall!.copyWith(
                            color: colorScheme(context).error,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0),
                      )),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Consumer<CheckBoxProvider>(
                builder: (context, value, child) {
                  return CustomElevatedButton(
                      buttonColor: value.isFocused
                          ? colorScheme(context).primary
                          : AppColor.buttonColor,
                      onPressed: () {
                        if (_key.currentState?.validate() ?? false) {
                          // context.pushNamed(AppRoute.bottomNav);
                          // After login or onboarding, navigate to the main screen with the bottom navigation
                          context.pushReplacementNamed(AppRoute
                              .bottomNav); // Assuming this is the route for the bottom nav
                        }
                      },
                      text: 'Login');
                },
              ),
              const SizedBox(
                height: 100,
              ),
              Center(
                  child: Text(
                'Or Continue With',
                style: textTheme(context)
                    .bodyLarge!
                    .copyWith(fontWeight: FontWeight.w500, letterSpacing: 0),
              )),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  customContainerWidget(
                    icon: AppIcons.googleIcon,
                  ),
                  customContainerWidget(
                      icon: AppIcons.facebookIcon, bgColor: AppColor.blueColor),
                  customContainerWidget(
                    icon: AppIcons.appleIcon,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don’t have an account?',
                    style: textTheme(context).bodyLarge!.copyWith(
                        fontWeight: FontWeight.w500, letterSpacing: 0),
                  ),
                  GestureDetector(
                      onTap: () {
                        context.pushNamed(AppRoute.singUpPage);
                      },
                      child: Text(
                        'SIGN UP',
                        style: textTheme(context).bodyLarge!.copyWith(
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0,
                            color: colorScheme(context).primary),
                      ))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget customContainerWidget({required String icon, Color? bgColor}) {
    return Padding(
      padding: const EdgeInsets.only(right: 10.0),
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
            color: bgColor ?? colorScheme(context).onPrimary,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColor.greyColor.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 1,
                offset: const Offset(0, 1),
              )
            ]),
        child: SvgPicture.asset(
          icon,
          height: 20,
        ),
      ),
    );
  }
}
