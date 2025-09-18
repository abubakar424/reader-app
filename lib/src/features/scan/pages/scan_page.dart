import 'package:file_picker/file_picker.dart';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '/src/common/constants/app_colors.dart';
import '/src/common/constants/app_images.dart';
import '/src/common/constants/global_variables.dart';
import '/src/router/routes.dart';

class ScanPage extends StatefulWidget {
  const ScanPage({super.key});

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  final ImagePicker _imagePicker = ImagePicker();

  // Function to pick a document file
  Future<void> _pickDocumentFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.any);
    if (result != null && result.files.single.path != null) {
      // Navigate to DocumentPreviewPage with the selected file path
      context.pushNamed(
        AppRoute.documentPreviewPage,
        extra: result.files.single.path,
      );
    }
  }

  // Function to pick an image from the gallery
  Future<void> _pickImageFromGallery() async {
    final XFile? pickedFile =
        await _imagePicker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      // Navigate to DocumentPreviewPage with the selected image file path
      context.pushNamed(
        AppRoute.documentPreviewPage,
        extra: pickedFile.path,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.peach,
      appBar: AppBar(
        backgroundColor: AppColor.peach,
        title: Text(
          "Scan Document",
          style: textTheme(context).headlineLarge?.copyWith(
                color: colorScheme(context).surface,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
        ),
        iconTheme: const IconThemeData(
            color: Colors.white), // Set the leading icon color to white

        actions: [
          InkWell(
            onTap: () {
              context.pushNamed(AppRoute.chooseLanguage);
            },
            child: Row(
              children: [
                Text(
                  "language",
                  style: textTheme(context).headlineLarge?.copyWith(
                      color: colorScheme(context).surface,
                      fontSize: 10,
                      fontWeight: FontWeight.w700),
                ),
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                  size: 20,
                )
              ],
            ),
          ),
          const SizedBox(
            width: 12,
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                Expanded(child: Container()),
                Container(
                  height: 335,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: colorScheme(context).surface,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "You can add something",
                          style: textTheme(context).headlineLarge?.copyWith(
                              color: AppColor.appBlue,
                              fontSize: 16,
                              fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap:
                                  _pickDocumentFile, // Opens file picker for Document row
                              child: Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 41,
                                    decoration: BoxDecoration(
                                      color: AppColor.peach,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppImages.docIcon,
                                        height: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    "Document",
                                    style: textTheme(context)
                                        .headlineLarge
                                        ?.copyWith(
                                            color: AppColor.appblue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 90),
                            GestureDetector(
                              onTap:
                                  _pickImageFromGallery, // Opens gallery picker for Gallery row
                              child: Row(
                                children: [
                                  Container(
                                    height: 32,
                                    width: 41,
                                    decoration: BoxDecoration(
                                      color: AppColor.blue,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: Image.asset(
                                        AppImages.gallery,
                                        height: 18,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Text(
                                    "Gallery",
                                    style: textTheme(context)
                                        .headlineLarge
                                        ?.copyWith(
                                            color: AppColor.appblue,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
