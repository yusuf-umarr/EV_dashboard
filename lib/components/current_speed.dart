import 'package:flutter/material.dart';

class CurrentSpeed extends StatelessWidget {
  final String speed;
  const CurrentSpeed({
    super.key, required this.speed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => const LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.white, Colors.white10],
          ).createShader(Rect.fromLTRB(0, 0, bounds.width, bounds.height)),
          child:  Text(
            speed,
            style: const TextStyle(
                fontSize: 96, fontWeight: FontWeight.w500, height: 0.96),
          ),
        ),
        const Text("km/h",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.white30)),
      ],
    );
  }
}
