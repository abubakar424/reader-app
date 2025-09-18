import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextFormField extends StatefulWidget {
  final int? maxline;
  final int? maxLength;
  final double? height;
  final double? hintSize;
  final FontWeight? fontWeight;
  final double? borderRadius;
  final double? horizontalPadding;
  final double? verticalPadding;
  final EdgeInsetsGeometry? contentPadding;
  final String? hint;
  final String? labelText;
  final String? initialValue;
  final bool? obscureText;
  final bool filled;
  final bool? isCollapsed;
  final bool? isDense;
  final bool? isEnabled;
  final bool? readOnly;
  final Color? fillColor;
  final Color? hintColor;
  final Color? inputColor;
  final Color? borderColor;
  final Color? focusBorderColor;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final TextInputAction? inputAction;
  final AutovalidateMode? autoValidateMode;
  final TextStyle? textStyle;
  final TextStyle? errorTextStyle;
  final InputDecoration? customDecoration;
  final String? semanticLabel;
  final List<TextInputFormatter>? inputFormatters;
  final BoxConstraints? prefixConstraint;
  final BoxConstraints? suffixConstraint;
  final void Function()? onTap;
  final void Function(String)? onChanged;
  final void Function(String)? onFieldSubmitted;
  final String? Function(String?)? validator;
  final TextEditingController? controller;

  const CustomTextFormField({
    super.key,
    this.maxline,
    this.maxLength,
    this.height,
    this.hintSize,
    this.fontWeight,
    this.borderRadius,
    this.horizontalPadding,
    this.verticalPadding,
    this.contentPadding,
    this.hint,
    this.labelText,
    this.initialValue,
    this.obscureText,
    this.filled = true,
    this.isCollapsed,
    this.isDense,
    this.isEnabled,
    this.readOnly,
    this.fillColor,
    this.hintColor,
    this.inputColor,
    this.borderColor,
    this.focusBorderColor,
    this.cursorColor,
    this.suffixIcon,
    this.prefixIcon,
    this.focusNode,
    this.keyboardType,
    this.inputAction,
    this.autoValidateMode,
    this.textStyle,
    this.errorTextStyle,
    this.customDecoration,
    this.semanticLabel,
    this.inputFormatters,
    this.prefixConstraint,
    this.suffixConstraint,
    this.onTap,
    this.onChanged,
    this.onFieldSubmitted,
    this.validator,
    this.controller,
  });

  @override
  _CustomTextFormFieldState createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: _focusNode,
      maxLength: widget.maxLength,
      obscureText: widget.obscureText ?? false,
      cursorColor: widget.cursorColor,
      maxLines: (widget.obscureText ?? false) ? 1 : (widget.maxline ?? 1),
      textInputAction: widget.inputAction,
      initialValue: widget.initialValue,
      style: widget.textStyle,
      keyboardType: widget.keyboardType,
      onChanged: widget.onChanged,
      inputFormatters: widget.inputFormatters,
      autovalidateMode:
          widget.autoValidateMode ?? AutovalidateMode.onUserInteraction,
      readOnly: widget.readOnly ?? false,
      enabled: widget.isEnabled ?? true,
      onTap: widget.onTap,
      onFieldSubmitted: widget.onFieldSubmitted,
      decoration: widget.customDecoration ??
          InputDecoration(
            labelText: widget.labelText,
            counterText: '',
            hintText: widget.hint,
            hintStyle: TextStyle(
                color: widget.hintColor ?? const Color(0xff9D9E9F),
                fontSize: widget.hintSize ?? 12,
                fontWeight: widget.fontWeight ?? FontWeight.w400),
            filled: widget.filled,
            fillColor: widget.fillColor ?? const Color(0xffF9F9F9),
            prefixIconConstraints: widget.prefixConstraint,
            suffixIconConstraints: widget.suffixConstraint,
            prefixIcon: widget.prefixIcon,
            suffixIconColor: const Color(0xff9D9E9F),
            suffixIcon: widget.suffixIcon,
            contentPadding: widget.contentPadding ??
                EdgeInsets.symmetric(
                  horizontal: widget.horizontalPadding ?? 20.0,
                  vertical: widget.verticalPadding ?? 10,
                ),
            errorStyle: widget.errorTextStyle,
            errorMaxLines: 2,
            isCollapsed: widget.isCollapsed ?? false,
            isDense: widget.isDense,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.focusBorderColor ?? Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            ),
            disabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: widget.borderColor ?? Colors.transparent,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(widget.borderRadius ?? 10),
            ),
          ),
      validator: widget.validator,
    );
  }
}
