import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';
import 'package:bearbox/core/extension/context_extension.dart';

class SelectorImage extends StatelessWidget {
  final double? width;
  final String? label;
  final Uint8List img;
  final double? height;
  final Function() onTap;

  const SelectorImage({
    super.key,
    this.label,
    this.width,
    this.height,
    required this.img,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) => img.isEmpty
      ? InkWell(
          onTap: onTap,
          child: DottedBorder(
            strokeWidth: 1,
            color: MyFitUiKit.util.color.textColor,
            borderType: BorderType.RRect,
            radius: const Radius.circular(12),
            padding: const EdgeInsets.all(6),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(12)),
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Text(
                  label ?? "UPLOAD IMAGE",
                  style: MyFitUiKit.util.textStyle.description,
                ),
              ),
            ),
          ),
        )
      : InkWell(
          onTap: onTap,
          child: Container(
            width: context.sizeWidth(width ?? 0.4),
            height: context.sizeHeight(height ?? 0.4),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(fit: BoxFit.fill, image: MemoryImage(img)),
            ),
          ),
        );
}
