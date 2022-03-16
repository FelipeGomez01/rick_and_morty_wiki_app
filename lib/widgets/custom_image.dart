import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  const CustomImage({
    Key? key,
    required this.urlImage,
    required this.size
  }) : super(key: key);

  final String urlImage;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7),
      child: FadeInImage(
        image: NetworkImage(
          urlImage
        ),
        placeholder: const AssetImage('assets/images/loading.gif'),
        height: size,
        width: size
      )
    );
  }
}
