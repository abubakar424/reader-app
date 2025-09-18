import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/app_images.dart';
import '../../../../common/constants/global_variables.dart';
import '../../../../common/utils/validation.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../router/routes.dart';

class ForgetPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _key = GlobalKey<FormState>();
  ForgetPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Forget password',
          style: textTheme(context)
              .headlineMedium!
              .copyWith(fontWeight: FontWeight.w500,),
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
              'Select which contact details should we use to Reset Your Password',
              style: textTheme(context)
                  .bodyLarge!
                  .copyWith(fontWeight: FontWeight.w500, letterSpacing: 0,color: AppColor.txtColor),
            ),
            const SizedBox(
              height: 20,
            ),
            customContainerWidget(context,
              TextInputType.text,
              labelText: 'Via Email',
              controller: emailController,
              validator: (value) => Validation.emailValidation(value),
            ),
            customContainerWidget(context,
              TextInputType.number,
              labelText: 'Via SMS',
              controller: phoneController,
              validator: (value) => Validation.fieldValidation(value,'sms'),
            ),
            const SizedBox(
              height: 100,
            ),
            CustomElevatedButton(
                onPressed: () {
                  if(_key.currentState?.validate() ?? false){
                    context.pushNamed(AppRoute.createPinPage);
                  }
                },
                text: 'Continue'),
          ],
        )),
      ),
    );
  }

  Widget customContainerWidget(
    BuildContext context, TextInputType? keyboardType, {
    required String labelText,
    required TextEditingController controller,
        required String? Function(String?)? validator
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
              child: TextFormField(autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: controller,
                keyboardType: keyboardType,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  label: Text(
                    labelText,
                    style: textTheme(context).labelLarge!.copyWith(
                        letterSpacing: 0,
                        color: colorScheme(context).onSurface),
                  ),
                ),
                validator: validator,
              ),
            )
          ],
        ),
      ),
    );
  }
}
