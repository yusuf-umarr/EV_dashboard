import 'package:car_dashbord/components/car_indicator.dart';
import 'package:car_dashbord/components/current_speed.dart';
import 'package:car_dashbord/components/gear_and_battery.dart';
import 'package:car_dashbord/components/speed_limit.dart';
import 'package:car_dashbord/components/time_and_temp.dart';
import 'package:car_dashbord/constants.dart';
import 'package:car_dashbord/painter/hmi_shape.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';

class HmiDashboard extends StatefulWidget {
  const HmiDashboard({super.key});

  @override
  State<HmiDashboard> createState() => _HmiDashboardState();
}

class _HmiDashboardState extends State<HmiDashboard> {
  final List<double> speedLinesOpacities = [
    1,
    0.89,
    0.6,
    0.4,
    0.3,
    0.2,
    0.15,
    0.1
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          child: (size.width > 1184 && size.height > 56)
              ? Container(
                  margin: const EdgeInsets.all(16),
                  constraints: const BoxConstraints(
                    maxHeight: 604,
                    minHeight: 456,
                    maxWidth: 1480,
                    minWidth: 1180,
                  ),
                  child: AspectRatio(
                    aspectRatio: 2.59,
                    child: LayoutBuilder(builder: (context, constraints) {
                      return CustomPaint(
                        painter: HmiShapePainter(),
                        child: Column(
                          children: [
                            TimeAndTemp(
                              constraints: constraints,
                            ),
                            Expanded(
                                child: Stack(
                              children: [
                                Column(
                                  children: [
                                    const SizedBox(
                                      height: defaultPadding * 1.25,
                                    ),
                                    const CarIndicators(),
                                    const Spacer(),
                                    const CurrentSpeed(
                                      speed: '54',
                                    ),
                                    const Spacer(),
                                    const SpeedLimit(),
                                    const SizedBox(
                                      height: defaultPadding * 0.75,
                                    ),
                                    GearAndBattery(
                                      constraints: constraints,
                                    ),
                                  ],
                                ),
                                ...List.generate(
                                  speedLinesOpacities.length,
                                  (index) => Positioned(
                                    left: constraints.maxWidth * 0.13 -
                                        (30 * index),
                                    bottom: 20 + (2 * index).toDouble(),
                                    height: constraints.maxHeight * 0.8,
                                    width: constraints.maxWidth * 0.31,
                                    child: Opacity(
                                      opacity: speedLinesOpacities[index],
                                      child: CustomPaint(
                                        painter: SpeedLinePainter(),
                                      ),
                                    ),
                                  ),
                                ),
                                ...List.generate(
                                  speedLinesOpacities.length,
                                  (index) => Positioned(
                                    right: constraints.maxWidth * 0.13 -
                                        (30 * index),
                                    bottom: 20 + (2 * index).toDouble(),
                                    height: constraints.maxHeight * 0.8,
                                    width: constraints.maxWidth * 0.31,
                                    child: Opacity(
                                      opacity: speedLinesOpacities[index],
                                      child: Transform.scale(
                                        scaleX: -1,
                                        child: CustomPaint(
                                          painter: SpeedLinePainter(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ))
                          ],
                        ),
                      );
                    }),
                  ))
              : const Center(child: Text("Sceen is too small to show the UI")),
        ));
  }
}

class SpeedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double strokeWidth = 8;

    Paint paintTop = Paint()
      ..style = PaintingStyle.fill
      ..color = primaryColor;

    Path pathTop = Path()
      ..moveTo(size.width * 0.78, 0)
      ..lineTo(size.width, size.height * 0.3)
      ..lineTo(size.width - strokeWidth, size.height * 0.3)
      ..close();

    Path pathBottom = Path()
      ..moveTo(size.width, size.height * 0.3)
      ..lineTo(40, size.height - 20)
      ..lineTo(size.width - strokeWidth, size.height * 0.3)
      ..close();

    canvas.drawPath(pathTop, paintTop);
    canvas.drawPath(pathBottom, paintTop);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
