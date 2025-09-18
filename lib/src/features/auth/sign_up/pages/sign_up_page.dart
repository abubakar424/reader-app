import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_images.dart';
import '../../../../common/constants/global_variables.dart';
import '../../../../common/utils/validation.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../../../router/routes.dart';
import '../../login/provider/check_box_provider.dart';

Color txtColor = const Color(0xff545454);

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _nameFocusNode = FocusNode();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  final validText = 'Please select gender';

  String? selectedGender;
  List<String> genders = ['Male', 'Female', 'Other'];

  final _key = GlobalKey<FormState>();
  bool isSubmitted = false;

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
    _nameFocusNode.addListener(() {
      Provider.of<CheckBoxProvider>(context, listen: false)
          .onFocusChange(_nameFocusNode.hasFocus);
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
                  'Sign up',
                  style: textTheme(context)
                      .headlineMedium!
                      .copyWith(fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  'Create Account to Continue your  Records ',
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
                    padding: const EdgeInsets.all(12.0), // Adjust as needed
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
                CustomTextFormField(
                  controller: nameController,
                  focusNode: _nameFocusNode,
                  hint: 'Name',
                  hintColor: txtColor,
                  hintSize: 14,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0), // Adjust as needed
                    child: SvgPicture.asset(
                      AppIcons.nameIcon,
                      width: 20,
                      height: 14,
                      fit: BoxFit.contain,
                    ),
                  ),
                  borderRadius: 100,
                  fillColor: Colors.transparent,
                  focusBorderColor: colorScheme(context).error,
                  borderColor: AppColor.greyColor.withOpacity(0.2),
                  validator: (value) => Validation.nameValidation(value),
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
                      validator: (value) =>
                          Validation.passwordValidation(value),
                      onChanged: (value) {
                        context.read<CheckBoxProvider>().onTextChange(value);
                      },
                    );
                  },
                ),
                const SizedBox(
                  height: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(
                                color: AppColor.greyColor.withOpacity(0.2))),
                        width: double.infinity,
                        child: DropdownButtonHideUnderline(
                          child: DropdownButtonFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                prefixIcon: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: SvgPicture.asset(
                                    AppIcons.nameIcon,
                                    height: 14,
                                    width: 20,
                                    fit: BoxFit.contain,
                                  ),
                                )),
                            hint: Text(
                              'Gender',
                              style: textTheme(context)
                                  .labelMedium!
                                  .copyWith(letterSpacing: 0),
                            ),
                            isExpanded: true,
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            validator: (newValue) {
                              if (newValue == null) {}
                              return null;
                            },
                            value: selectedGender,
                            style: GoogleFonts.poppins(
                                color: colorScheme(context).onSurface,
                                fontSize: 14),
                            items: genders.map((String value) {
                              return DropdownMenuItem(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                        )),
                    if (isSubmitted &&
                        selectedGender ==
                            null) // Only show the error text if no selection is made
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0, top: 3),
                        child: Text(
                          validText,
                          style: textTheme(context).bodySmall!.copyWith(
                              color: colorScheme(context).error,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                              fontSize: 12),
                        ),
                      ),
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
                          setState(() {
                            isSubmitted = true;
                          });
                          if (_key.currentState?.validate() ?? false) {
                            context.pushNamed(AppRoute.bottomNav);
                          }
                        },
                        text: 'SignUP');
                  },
                ),
                const SizedBox(
                  height: 30,
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
                        icon: AppIcons.facebookIcon,
                        bgColor: AppColor.blueColor),
                    customContainerWidget(
                      icon: AppIcons.appleIcon,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an Account?',
                      style: textTheme(context).bodyLarge!.copyWith(
                          fontWeight: FontWeight.w500, letterSpacing: 0),
                    ),
                    InkWell(
                        onTap: () {
                          context.pushNamed(AppRoute.loginPage);
                        },
                        child: Text(
                          'LOGIN',
                          style: textTheme(context).bodyLarge!.copyWith(
                              fontWeight: FontWeight.w500,
                              letterSpacing: 0,
                              color: colorScheme(context).primary),
                        ))
                  ],
                )
              ],
            )),
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
