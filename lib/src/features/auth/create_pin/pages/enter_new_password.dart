import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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

class EnterNewPasswordPage extends StatefulWidget {

  const EnterNewPasswordPage({super.key});

  @override
  State<EnterNewPasswordPage> createState() => _EnterNewPasswordPageState();
}

class _EnterNewPasswordPageState extends State<EnterNewPasswordPage> {
  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isValue = true;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Create New Pin',
          style: textTheme(context)
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w500),
        ),
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
              'Add a Pin Number to Make Your Account more Secure',
              style: textTheme(context).bodyLarge!.copyWith(
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0,
                  color: txtColor),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Create Your New Password',
              style: textTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500, letterSpacing: 0),
            ),
            const SizedBox(
              height: 20,
            ),
            Consumer<CheckBoxProvider>(
              builder: (context, provider, child) {
                return CustomTextFormField(
                  controller: passwordController,
                  hint: 'Password',
                  hintColor: txtColor,
                  obscureText: provider.isVisible,
                  hintSize: 14,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.all(12.0),
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
              height: 8,
            ),
            CustomTextFormField(
              obscureText: isValue,
              controller: confirmPasswordController,
              hint: 'Confirm password',
              hintColor: txtColor,
              hintSize: 14,
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12.0),
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
                  isValue
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: colorScheme(context).onSurface,
                ),
                onPressed: () {
                  setState(() {
                    isValue =! isValue;
                  });
                },
              ),
              focusBorderColor: colorScheme(context).error,
              borderColor: AppColor.greyColor.withOpacity(0.2),
              validator: (value) => Validation.confirmPassword(value,passwordController.text),
            ),
            const SizedBox(
              height: 100,
            ),
            CustomElevatedButton(
                onPressed: () {
                  if(_key.currentState?.validate() ?? false){
                    showMyDialog(context);
                  }
                },
                text: 'Continue'),
          ],
        )),
      ),
    );
  }

  Widget customContainerWidget(
    BuildContext context, {
    required String labelText,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        height: 80,
        decoration: BoxDecoration(
          border: Border.all(color: AppColor.greyColor.withOpacity(0.2)),
          borderRadius: BorderRadius.circular(100),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.transparent,
                shape: BoxShape.circle,
                border:
                    Border.all(color: colorScheme(context).secondary, width: 2),
              ),
              child: SvgPicture.asset(
                AppIcons.greenEmailIcon,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Expanded(
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text(
                    labelText,
                    style: textTheme(context).labelLarge!.copyWith(
                        letterSpacing: 0,
                        color: colorScheme(context).onSurface),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future showMyDialog(BuildContext context) async {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(
                AppImages.dialog,
                width: 150,
              ),
              Text(
                'Congratulations',
                style: textTheme(context)
                    .headlineMedium!
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'Your Account is Ready to Use. You will be redirected to the Home Page in a Few Seconds.',
                textAlign: TextAlign.center,
                style: textTheme(context).bodyLarge!.copyWith(
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0,
                    color: txtColor),
              ),
              const SizedBox(
                height: 10,
              ),
              InkWell(
                onTap: (){
                  context.pushNamed(AppRoute.loginPage);
                },
                child: Container(
                  height: 38,
                  decoration: BoxDecoration(
                      color: colorScheme(context).primary,
                      borderRadius: BorderRadius.circular(27)),
                  child: Center(
                    child: Text(
                      'Back to Login',
                      style: textTheme(context).bodyLarge!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: colorScheme(context).onPrimary),
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
