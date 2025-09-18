import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/app_colors.dart';
import '../../../common/constants/global_variables.dart';

class DocumentBox extends StatelessWidget {
  final String iconPath; // Use icon path instead of IconData
  final String title;
  final int fileCount;
  final Color color;
  final VoidCallback onTap;

  const DocumentBox({
    super.key,
    required this.title,
    required this.fileCount,
    required this.color,
    required this.onTap,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: colorScheme(context).surface,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: colorScheme(context).outline),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon Container
              Container(
                height: 32,
                width: 41,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: SvgPicture.asset(
                    iconPath,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              // Title and File Count Column
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textTheme(context).headlineLarge?.copyWith(
                          color: AppColor.appblue,
                          fontSize: 12,
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '$fileCount Files',
                      style: textTheme(context).headlineLarge?.copyWith(
                          color: AppColor.appblue,
                          fontSize: 10,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
