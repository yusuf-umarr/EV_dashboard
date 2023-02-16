import 'dart:ui';

import 'package:car_dashbord/constants.dart';
import 'package:flutter/material.dart';

class DashLinePainter extends CustomPainter {
  final double progress;

  DashLinePainter({required this.progress});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 8
      ..strokeJoin = StrokeJoin.round
      ..color = primaryColor;

    Path path = Path()
      ..moveTo(0, size.height / 2)
      ..lineTo(size.width * progress, size.height / 2);

    //dash line
    Path dashPath = Path();
    double dashWidth = 24;
    double dashSpace = 2;
    double distance = 0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
    }
    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(DashLinePainter oldDelegate) =>
      oldDelegate.progress != progress;
}

