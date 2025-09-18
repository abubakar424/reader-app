import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/widgets/custom_button.dart';
import '../../../router/routes.dart';
import '../../bottom_nav/widget/controller.dart';
import '../../home/provider/document.dart';

class AppointmentPage extends StatefulWidget {
  final String documentPath;
  const AppointmentPage({super.key, required this.documentPath});

  @override
  State<AppointmentPage> createState() => _AppointmentPageState();
}

class _AppointmentPageState extends State<AppointmentPage> {
  late String _currentDocumentPath;

  @override
  void initState() {
    super.initState();
    _currentDocumentPath = widget.documentPath;
  }

  // Function to share the file
  void _shareFile() {
    Share.shareXFiles(
      [XFile(_currentDocumentPath)],
      text: 'Here is the document!',
    );
  }

  // Function to delete the image
  void _deleteImage() {
    setState(() {
      _currentDocumentPath = '';
    });
  }

  // Function to select a new image from the gallery
  Future<void> _selectNewImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? newImage = await picker.pickImage(source: ImageSource.gallery);
    if (newImage != null) {
      setState(() {
        _currentDocumentPath = newImage.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Appointments',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    "Image",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  Text(
                    "Word",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface,
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Center(
                child: SizedBox(
                  height: 336,
                  width: 264,
                  child: _currentDocumentPath.isNotEmpty
                      ? Image.file(
                          File(_currentDocumentPath),
                          fit: BoxFit.contain,
                        )
                      : const Icon(
                          Icons.image_not_supported,
                          color: Colors.grey,
                          size: 100,
                        ),
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      context.pushNamed(AppRoute.documentPreviewPage,
                          extra: _currentDocumentPath,  );// Pass the documentPath here

                    },
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.editIcon,
                          height: 14,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Edit",
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: AppColor.darkGreen,
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 28),
                  GestureDetector(
                    onTap: _shareFile,
                    child: Column(
                      children: [
                        Image.asset(
                          AppImages.share,
                          height: 14,
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Share",
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColor.darkGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 20),
                  Column(
                    children: [
                      PopupMenuButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 8,
                        offset:
                            const Offset(80, -90), // Adjusts position of popup
                        itemBuilder: (BuildContext context) => [
                          PopupMenuItem(
                            onTap: () => Future.delayed(
                              Duration.zero,
                              _deleteImage,
                            ),
                            child: const Text("Delete"),
                          ),
                          PopupMenuItem(
                            onTap: () => Future.delayed(
                              Duration.zero,
                              _selectNewImage,
                            ),
                            child: const Text("New Image"),
                          ),
                        ],
                        icon: Column(
                          children: [
                            Image.asset(
                              AppImages.more,
                              height: 14,
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "More",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: AppColor.darkGreen,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 120),
//               CustomButton(
//   onTap: () {
//     final documentProvider = Provider.of<DocumentProvider>(context, listen: false);
//     documentProvider.addDocumentFromAppointment(_currentDocumentPath);

//     // Use the global PersistentTabController to jump to FilesPage
//     globalPersistentTabController.jumpToTab(1);  // FilesPage is at index 1
//   },
//   borderradius: 50,
//   text: "Done",
// )

              

              CustomButton(
                onTap: () {
                  final documentProvider =
                      Provider.of<DocumentProvider>(context, listen: false);
                  documentProvider
                      .addDocumentFromAppointment(_currentDocumentPath);

                  // Pop back to the main stack and select FilesPage
                  Navigator.of(context).popUntil((route) => route.isFirst);

                  // Access the global PersistentTabController to jump to FilesPage
                  globalPersistentTabController.jumpToTab(
                      1); // Assuming FilesPage is at index 2 in the tab controller
                },

                borderradius: 50,
                text: "Done",
              ),
            ],
          ),
        ),
      ),
    );
  }
}
