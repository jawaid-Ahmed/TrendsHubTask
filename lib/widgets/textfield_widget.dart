import 'package:flutter/material.dart';
import 'package:trends_hub/constants/my_theme.dart';

class CustomTextField extends StatefulWidget {
  CustomTextField({
    Key? key,
    this.borderColor,
    required this.controller,
    this.hintColor,
    this.hintText,
    this.keyboardType,
    this.onChange,
    this.validator,
    this.enabled = true,
    this.suffixIcon,
    this.prefixIcon,
  }) : super(key: key);

  final bool enabled;
  Function(String)? onChange;

  final Color? borderColor;
  TextEditingController controller;
  final Color? hintColor;
  final String? hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  TextInputType? keyboardType;

  String? Function(String?)? validator;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
        controller: widget.controller,
        onChanged: widget.onChange,
        keyboardType: widget.keyboardType,
        decoration: InputDecoration(
          labelText: widget.hintText,
          hintStyle: TextStyle(color: MyThemes.hintColor),
          suffixIcon: widget.suffixIcon,
          labelStyle: const TextStyle(color: MyThemes.textColor),
          floatingLabelStyle: TextStyle(color: MyThemes.primaryColor),
          prefixIcon: widget.prefixIcon != null
              ? Icon(
                  widget.prefixIcon,
                  color: MyThemes.iconColor,
                )
              : null,
          border: myinputborder(),
          enabledBorder: myinputborder(),
          focusedBorder: myfocusborder(),
        ));
  }

  OutlineInputBorder myinputborder() {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: widget.borderColor ?? Colors.grey.shade300,
          width: 1,
        ));
  }

  OutlineInputBorder myfocusborder() {
    return OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        borderSide: BorderSide(
          color: MyThemes.primaryColor,
          width: 1,
        ));
  }
}
