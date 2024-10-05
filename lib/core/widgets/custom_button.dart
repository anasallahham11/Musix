import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({Key? key, this.height, this.width, this.icon, this.iconSize, this.backgroundColor, this.function, this.iconColor}) : super(key: key);

  final void Function()? function;
  final double? height;
  final double? width;
  final IconData? icon;
  final double? iconSize;
  final Color? backgroundColor;
  final Color? iconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: backgroundColor
        ),
        child: Icon(
          icon,
          size: iconSize,
          color: iconColor,
        ),
      ),
    );
  }
}
