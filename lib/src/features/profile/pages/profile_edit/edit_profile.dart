import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../common/constants/app_colors.dart';
import '../../../../common/constants/global_variables.dart';
import '../../../../common/widgets/custom_button.dart';
import '../../../../common/widgets/custom_text_field.dart';
import '../../provider/provider1.dart';
import '../../widgets/custom_profile.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController bioController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool validateFields() {
    return _formKey.currentState?.validate() ?? false;
  }

  XFile? selectedImage;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      Provider.of<ImageProviderNotifier>(context, listen: false)
          .updateImage(File(pickedImage.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ImageProviderNotifier>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Edit Profile",
          style: textTheme(context)
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          width: double.infinity,
          child: Column(
            children: [
              const SizedBox(height: 20),
              CustomProfile(
                onTap: () {
                  _pickImage();
                },
                color: AppColor.appBlue,
              ),
              const SizedBox(height: 10),
              Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomTextFormField(
                        validator: (value) => value?.isEmpty ?? true
                            ? "First Name is required"
                            : null,
                        controller: firstName,
                        hint: "First Name",
                        textStyle: textTheme(context).bodyMedium,
                        borderColor: colorScheme(context).primary,
                        borderRadius: 10,
                        focusBorderColor: colorScheme(context).primary,
                        cursorColor: colorScheme(context).primary,
                        onChanged: (value) =>
                            profileProvider.updateFirstName(value),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 10,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: colorScheme(context).primary))),
                            child: Center(
                                child: Text(
                              "First Name",
                              style: textTheme(context).bodyMedium,
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        validator: (value) => value?.isEmpty ?? true
                            ? "Last Name is required"
                            : null,
                        controller: lastName,
                        hint: "Last Name",
                        textStyle: textTheme(context).bodyMedium,
                        borderColor: colorScheme(context).primary,
                        borderRadius: 10,
                        focusBorderColor: colorScheme(context).primary,
                        cursorColor: colorScheme(context).primary,
                        onChanged: (value) =>
                            profileProvider.updateLastName(value),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 10,
                            width: 100,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: colorScheme(context).primary))),
                            child: Center(
                                child: Text(
                              "Last Name",
                              style: textTheme(context).bodyMedium,
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      CustomTextFormField(
                        validator: (value) =>
                            value?.isEmpty ?? true ? "Bio is required" : null,
                        controller: bioController,
                        hint: "Bio",
                        textStyle: textTheme(context).bodyMedium,
                        borderColor: colorScheme(context).primary,
                        borderRadius: 10,
                        focusBorderColor: colorScheme(context).primary,
                        cursorColor: colorScheme(context).primary,
                        onChanged: (value) => profileProvider.updateBio(value),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            height: 10,
                            width: 50,
                            decoration: BoxDecoration(
                                border: Border(
                                    right: BorderSide(
                                        color: colorScheme(context).primary))),
                            child: Center(
                                child: Text(
                              "Bio",
                              style: textTheme(context).bodyMedium,
                            )),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      IntlPhoneField(
                        validator: (value) {
                          if (value == null || value.number.isEmpty) {
                            return 'Phone number is required';
                          } else if (value.number.length < 10) {
                            return 'Enter a valid phone number';
                          }
                          return null;
                        },
                        disableLengthCheck: true,
                        controller: phoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        initialCountryCode: 'PK',
                      ),
                      const SizedBox(height: 30),
                    ],
                  )),
              CustomButton(
                  onTap: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      context.pop(context);
                    }
                  },
                  text: "Done")
            ],
          ),
        ),
      ),
    );
  }
}
