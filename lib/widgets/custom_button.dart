import 'package:flutter/material.dart';
import 'package:trends_hub/constants/my_theme.dart';
import 'package:trends_hub/widgets/custom_textview.dart';

class CustomButton extends StatelessWidget {
  double? height;
  double? width;
  Color? bgColor;
  Color? textColor;
  double? radius;
  String text;
  IconData? prefixIcon;
  IconData? postFixIcon;
  double? textSize;
  double? iconSize;
  EdgeInsetsGeometry? margin;
  Color? iconColor;
  Function onPressed;
  bool enabled;
  Widget? prefixWidget;
  Widget? postFixWidget;

  CustomButton(
      {super.key,
      this.enabled = true,
      this.height,
      this.width,
      this.bgColor,
      this.textColor,
      this.postFixIcon,
      this.prefixIcon,
      required this.text,
      this.textSize,
      this.iconSize,
      this.radius,
      this.iconColor,
      required this.onPressed,
      this.postFixWidget,
      this.prefixWidget,
      this.margin});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: enabled
          ? () {
              onPressed.call();
            }
          : null,
      child: Container(
        height: height ?? 55,
        width: width ?? size.width * 0.5,
        margin: margin ?? const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius ?? 0),
          color: (enabled)
              ? bgColor ?? MyThemes.primaryColor
              : Colors.grey.shade500,
          //border: Border.all(width: 1, color: MyThemes.primaryColor),
        ),
        child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          if (prefixWidget != null) ...[
            prefixWidget!
          ] else ...[
            if (prefixIcon != null) ...[
              Icon(
                prefixIcon,
                size: iconSize ?? 22,
                color: iconColor ?? MyThemes.primaryColor,
              ),
              const SizedBox(
                width: 15,
              ),
            ],
          ],
          Expanded(
            child: Center(
              child: CustomTextView(
                text: text,
                textColor: textColor ?? Colors.white,
                textSize: textSize,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          if (postFixWidget != null) ...[
            postFixWidget!
          ] else ...[
            if (postFixIcon != null) ...[
              Icon(
                postFixIcon,
                size: iconSize ?? 32,
                color: iconColor ?? MyThemes.primaryColor,
              )
            ]
          ],
        ]),
      ),
    );
  }
}
