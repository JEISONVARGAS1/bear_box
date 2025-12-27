import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:my_fit_ui_kit/my_fit_ui_kit.dart';

class DashedBorderContainer extends StatelessWidget {
  final String label;
  final Color? color;

  const DashedBorderContainer({super.key, required this.label, this.color});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CustomPaint(
        painter: DashedBorderPainter(),
        child: Container(
          height: 100,
          width: double.infinity,
          alignment: Alignment.center,
          child:  Text(label, style: MyFitUiKit.util.textStyle.subTitle),
        ),
      ),
    );
  }
}

class DashedBorderPainter extends CustomPainter {
  Color? color;

  DashedBorderPainter({this.color});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint =
        Paint()
          ..strokeWidth = 2
          ..style = PaintingStyle.stroke
          ..strokeCap = StrokeCap.round
          ..color = color ?? MyFitUiKit.util.color.card;

    Path path =
        Path()..addRRect(
          RRect.fromRectAndRadius(
            Rect.fromLTWH(0, 0, size.width, size.height),
            Radius.circular(16), // Radio de las esquinas
          ),
        );

    _drawDashedPath(canvas, path, paint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    double dashWidth = 8, dashSpace = 4;
    PathMetrics pathMetrics = path.computeMetrics();

    for (PathMetric pathMetric in pathMetrics) {
      double distance = 0;
      while (distance < pathMetric.length) {
        Path extractPath = pathMetric.extractPath(
          distance,
          distance + dashWidth,
        );
        canvas.drawPath(extractPath, paint);
        distance += dashWidth + dashSpace;
      }
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
