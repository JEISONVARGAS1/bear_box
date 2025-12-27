import 'package:bearbox/core/extension/context_extension.dart';
import 'package:flutter/material.dart';

class ImageSelected extends StatelessWidget {
  final String networkImage;
  final Function() onTap;

  const ImageSelected({
    super.key,
    required this.onTap,
    required this.networkImage,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: () => onTap,
        child: Container(
          width: context.sizeWidth() * 0.4,
          height: context.sizeHeight() * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            image: DecorationImage(image: NetworkImage(networkImage)),
          ),
        ),
      );
}
