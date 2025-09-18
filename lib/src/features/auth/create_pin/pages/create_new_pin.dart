import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/global_variables.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../router/routes.dart';

class CreateNewPinPage extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final _key = GlobalKey<FormState>();
  CreateNewPinPage({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Pin',style: textTheme(context).headlineMedium!.copyWith(fontWeight: FontWeight.w500),),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _key,
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add a Pin Number to Make Your Account more Secure',style: textTheme(context).bodyLarge!.copyWith(fontWeight: FontWeight.w500,letterSpacing: 0,color: AppColor.txtColor),),
            const SizedBox(height: 20,),
            PinCodeTextField(
              validator: (value) {
                if(value == null || value.isEmpty){
                  return 'Pin code are required';
                }
                if (value.length != 4) {
                  return 'Pin code must be 4 digits';
                }
                return null;
              },
              appContext: context,
              length: 4,
              keyboardType: TextInputType.number,
              obscureText: true,
              obscuringCharacter: '*',
              pinTheme: PinTheme(
                shape: PinCodeFieldShape.box,
                fieldHeight: 60,
                fieldWidth: 75,
                borderRadius: BorderRadius.circular(12),
                inactiveColor: AppColor.greyColor.withOpacity(0.2),
                inactiveFillColor: AppColor.greyColor.withOpacity(0.2),
                activeColor: AppColor.greyColor.withOpacity(0.2),
                selectedColor: AppColor.greyColor
              ),
            ),
            const SizedBox(height: 100,),
            CustomElevatedButton(
                onPressed: (){
                  if(_key.currentState?.validate() ?? false){
                    context.pushNamed(AppRoute.enterNewPasswordPage);
                  }
                }, text: 'Continue'),
          ],
        )),
      ),
    );
  }
}
