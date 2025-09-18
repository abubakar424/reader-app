import 'package:flutter/material.dart';
import '../constants/global_variables.dart';

class CustomButton extends StatelessWidget {
  final Function() onTap;
  final String text;
  final double? width;
  final double? height;
  final bool isBig;
  final Color? bgcolor;
  final Color? shadowcolor;
  final Color? txtcolor;
  final FontWeight? fontWeight;
  final double? textsize;
  final double? borderradius;

  const CustomButton(
      {super.key,
      required this.onTap,
      required this.text,
      this.width,
      this.height,
      this.isBig = true,
      this.bgcolor,
      this.shadowcolor,
      this.txtcolor,
      this.fontWeight,
      this.textsize,
      this.borderradius});

  @override
  Widget build(BuildContext context) {
    final width1 = MediaQuery.of(context).size.width;

    return InkWell(
      splashColor: colorScheme(context).primary,
      onTap: onTap,
      child: Container(
        width: width ?? MediaQuery.sizeOf(context).width,
        height: height ?? 50,
        decoration: BoxDecoration(
            boxShadow: const [],
            borderRadius: BorderRadius.circular(
                isBig ? width1 * 0.1 : borderradius ?? width1 * 0.04),
            color: bgcolor ?? colorScheme(context).primary),
        child: Center(
          child: SizedBox(
            width: width1 * 0.4,
            child: Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: txtcolor ?? colorScheme(context).onPrimary,
                  fontWeight: fontWeight ?? FontWeight.w600,
                  fontSize: textsize ?? 16),
            ),
          ),
        ),
      ),
    );
  }
}

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final double? width;
  final Color? textColor;
  final Color? buttonColor;

  const CustomElevatedButton({
    required this.onPressed,
    required this.text,
    this.width,
    this.textColor,
    this.buttonColor,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:  width ?? double.infinity,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor ?? colorScheme(context).primary ,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), // Rounded corners
          ),
        ),
        child: Text(text,style: textTheme(context).titleMedium!.copyWith(letterSpacing: 0,fontWeight: FontWeight.w600,color: textColor ?? colorScheme(context).onPrimary),),
      ),
    );
  }
}
