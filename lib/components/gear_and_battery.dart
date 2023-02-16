import 'dart:ui';

import 'package:car_dashbord/components/gear.dart';
import 'package:car_dashbord/constants.dart';
import 'package:car_dashbord/painter/battery_clipper.dart';
import 'package:car_dashbord/painter/dash_line_painter.dart';
import 'package:car_dashbord/painter/gear_painter.dart';
import 'package:flutter/material.dart';

class GearAndBattery extends StatelessWidget {
  final BoxConstraints constraints;
  const GearAndBattery({
    super.key,
    required this.constraints,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: constraints.maxHeight * 0.22,
      width: constraints.maxWidth * 0.74,
      child: CustomPaint(
        painter: GearPainter(),
        child: LayoutBuilder(builder: (context, gearConstraints) {
          return Stack(
            fit: StackFit.expand,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        top: defaultPadding / 2, bottom: defaultPadding / 4),
                    child: Gears(
                      constraints: gearConstraints,
                    ),
                  ),
                  const Text.rich(
                    TextSpan(
                        text: "Rest. ",
                        style: TextStyle(fontSize: 16, color: Colors.white54),
                        children: [
                          TextSpan(
                              text: "465km",
                              style: TextStyle(
                                color: Color(0xFF77C000),
                              ))
                        ]),
                  ),
                  SizedBox(
                    width: gearConstraints.maxWidth * 0.74,
                    child: Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(right: defaultPadding / 2),
                          child: Text(
                            "E",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.white10,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Expanded(
                            child: SizedBox(
                          height: 6,
                          child: ClipPath(
                            clipper: BatteryClipper(),
                            child: CustomPaint(
                              painter: DashLinePainter(progress: 1),
                            ),
                          ),
                        )),
                        //Container(height: 8, color: primaryColor)
                        const Padding(
                          padding: EdgeInsets.only(left: defaultPadding / 2),
                          child: Text(
                            "100%",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(0xff77c000),
                                fontWeight: FontWeight.w500),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: defaultPadding / 2,
                  ),
                ],
              ),
              Positioned(
                top: gearConstraints.maxHeight * 0.1,
                left: gearConstraints.maxWidth * 0.16,
                width: gearConstraints.maxWidth * 0.17,
                height: gearConstraints.maxHeight * 0.38,
                child: CustomPaint(
                  painter: AvgWattPerKmPainter(),
                  child: DefaultTextStyle(
                    style: TextStyle(fontSize: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: gearConstraints.maxWidth * 0.028,
                        ),
                        Text(
                          "Avg. ",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.16)),
                        ),
                        Text(
                          "11.3 w/km",
                          style:
                              TextStyle(color: Colors.white.withOpacity(0.32)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned(
                  top: gearConstraints.maxHeight * 0.1,
                  right: gearConstraints.maxWidth * 0.16,
                  width: gearConstraints.maxWidth * 0.17,
                  height: gearConstraints.maxHeight * 0.38,
                  child: CustomPaint(
                    painter: OdoPainter(),
                    child: DefaultTextStyle(
                      style: TextStyle(fontSize: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "ODO ",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.16)),
                          ),
                          Text(
                            "66.6 w/km",
                            style: TextStyle(
                                color: Colors.white.withOpacity(0.32)),
                          ),
                          SizedBox(
                            width: gearConstraints.maxWidth * 0.028,
                          ),
                        ],
                      ),
                    ),
                  ))
            ],
          );
        }),
      ),
    );
  }
}

class AvgWattPerKmPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    double strokeWidth = 4;

    Path path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width * 0.27, 0)
      ..lineTo(size.width, 0)
      ..lineTo(size.width * 0.27, strokeWidth)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class OdoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = primaryColor
      ..style = PaintingStyle.fill;

    double strokeWidth = 4;

    Path path = Path()
      ..lineTo(size.width * 0.73, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(size.width * 0.72, strokeWidth)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
