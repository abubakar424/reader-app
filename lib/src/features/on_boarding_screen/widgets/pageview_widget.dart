import 'package:flutter/material.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';

List<Widget> buildPages(BuildContext context) {
  return [
    _buildPage(
      context: context,
      image: AppImages.documentAnalysis,
      title: 'Grant Permissions',
      description:
          'To provide the best experience, please\n allow access to your camera and\n storage.',
    ),
    _buildPage(
      context: context,
      image: AppImages.notes,
      title: 'Document Scanning Made Easy',
      description:
          'Simply point your camera and let Readr\n detect and digitize your documents\n effortlessly.',
    ),
    _buildPage(
      context: context,
      image: AppImages.readingAvatar,
      title: 'Explore Reading Options',
      description:
          'Enjoy text-to-speech functionality with\n customizable voice options. Experience your documents in a whole new way!',
    ),
    _buildMultiImagePage(
      context,
      images: [
        AppImages.freePikAvatar,
        AppImages.search, // Replace with actual image constant
        AppImages.freePikPuzzle, // Replace with actual image constant
      ],
      title: 'Stay Organized',
      description:
          'Save your scanned documents locally for easy access and management whenever you need them.',
    ),
  ];
}

Widget _buildPage({
  required BuildContext context,
  required String image,
  required String title,
  required String description,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Spacer(),
      Flexible(
          flex: 3,
          child: Image.asset(
            image,
          )),
      const Spacer(),
      Text(
        title,
        style: textTheme(context).bodyMedium!.copyWith(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: AppColor.boardingScreenText),
      ),
      const SizedBox(
        height: 6,
      ),
      Text(
        description,
        textAlign: TextAlign.center,
        style: textTheme(context).bodyMedium!.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: AppColor.boardingScreenText),
      ),
      const Spacer()
    ],
  );
}

Widget _buildMultiImagePage(BuildContext context,
    {required List<String> images,
    required String title,
    required String description}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const Spacer(), // Spacing between the text and images
      SizedBox(
        width: 300,
        height: 240,
        child: Stack(
          children: [
            Positioned(
              left: 70,
              top: 40,
              child: Image.asset(images[0], width: 170, height: 180),
            ),
            Positioned(
              left: 80,
              top: 60,
              child: Image.asset(images[1], width: 70, height: 70),
            ),
            Positioned(
              left: 25,
              top: 167,
              child: Image.asset(images[2], width: 140, height: 60),
            ),
            // Add more Positioned widgets for additional images as needed
          ],
        ),
      ),
      const Spacer(),
      Text(
        title,
        style: textTheme(context).bodyMedium!.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: AppColor.boardingScreenText,
            ),
      ),
      const SizedBox(height: 6),
      Text(
        description,
        textAlign: TextAlign.center,
        style: textTheme(context).bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColor.boardingScreenText,
            ),
      ),
      const Spacer()
    ],
  );
}
