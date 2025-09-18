import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../common/constants/app_images.dart';
import '../../../common/constants/global_variables.dart';
import '../provider/provider1.dart';

class CustomProfile extends StatelessWidget {
  final VoidCallback onTap;
  final Color color;

  const CustomProfile({
    super.key,
    required this.onTap,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final imageProvider = Provider.of<ImageProviderNotifier>(context);

    return SizedBox(
      height: 110,
      width: 100,
      child: Stack(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: imageProvider.selectedImage != null
                ? FileImage(imageProvider.selectedImage!)
                : AssetImage(AppImages.profile) as ImageProvider,
            backgroundColor: colorScheme(context).secondary,
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: GestureDetector(
              onTap: onTap,
              child: Container(
                height: 36,
                width: 36,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: colorScheme(context).onPrimary,
                  border: Border.all(color: color),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    AppIcons.file,
                    width: 20,
                    height: 18,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
