import 'package:flutter/material.dart';

import '../../../common/constants/global_variables.dart';

class CustomLogoutButton extends StatelessWidget {
  final double height;
  final double width;
  final Color decorationcolor;
  final VoidCallback ontab;
  final Color bordercolor;
  final String text;
  final Color textcolor;
  const CustomLogoutButton(
      {super.key,
      required this.decorationcolor,
      required this.height,
      required this.width,
      required this.bordercolor,
      required this.text,
      required this.ontab,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontab,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: decorationcolor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: bordercolor),
        ),
        child: Center(
            child: Text(
          text,
          style: textTheme(context).bodySmall?.copyWith(color: textcolor),
        )),
      ),
    );
  }
}
