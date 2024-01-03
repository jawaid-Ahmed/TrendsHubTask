import 'package:flutter/material.dart';

class CustomTextView extends StatelessWidget {
  final String text;
  Color? textColor;
  double? textSize;
  int? maxLines;
  FontWeight? fontWeight;
  TextAlign? textAlign;
  dynamic direction;

  CustomTextView({
    super.key,
    required this.text,
    this.fontWeight,
    this.textAlign,
    this.direction,
    this.maxLines,
    this.textColor,
    this.textSize,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines ?? 1,
      textAlign: textAlign,
      textDirection: this.direction,
      style: TextStyle(
        fontSize: textSize ?? 16,
        fontWeight: fontWeight ?? FontWeight.normal,
        overflow: TextOverflow.ellipsis,
        fontFamily: 'DM Sans',
        color: textColor ?? Theme.of(context).cardColor,
      ),
    );
  }
}
