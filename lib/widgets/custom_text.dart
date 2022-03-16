import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText({
    Key? key,
    required this.text,
    this.size = 14,
    this.paddingVertical = 4,
    this.ellipsis = true
  }) : super(key: key);

  final String text;
  final double size;
  final double paddingVertical;
  final bool ellipsis;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: paddingVertical),
      child: Text(
        text,
        style: TextStyle(
          overflow: ellipsis ? TextOverflow.ellipsis : TextOverflow.visible,
          fontWeight: FontWeight.w900,
          fontSize: size
        )
      )
    );
  }
}