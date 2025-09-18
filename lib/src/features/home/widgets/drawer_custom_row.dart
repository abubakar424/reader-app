import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../common/constants/global_variables.dart';

class DrawerCustomRow extends StatelessWidget {
  final String? icon;
  final String? text;

  const DrawerCustomRow({super.key, required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(
          icon!,
        ),
        const SizedBox(width: 14),
        Text(text!,
        style: textTheme(context).headlineLarge?.copyWith(
                color: colorScheme(context).onSurface,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
                )
      ],
    );
  }
}
