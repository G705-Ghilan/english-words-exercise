import 'package:english_words_exercise/source/constance.dart';
import 'package:flutter/material.dart';

import 'package:percent_indicator/circular_percent_indicator.dart';

class CircularIndicator extends StatelessWidget {
  final double precent;
  final Color progressColor;
  final Color backgroundColor;
  final double radius;
  final bool isItem;
  const CircularIndicator(
      {super.key,
      required this.precent,
      this.progressColor = const Color(0xFFFF00ED),
      this.backgroundColor = Colors.white,
      this.radius = 65,
      this.isItem = false});

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: radius,
      lineWidth: isItem ? 5 : 8,
      animation: true,
      percent: precent * 1.0,
      progressColor: progressColor,
      backgroundColor: backgroundColor,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        "${(precent * 100.0).toStringAsFixed(0)}%",
        style: isItem
            ? CONSTANCE.itemPrecentTextSTyle
            : Theme.of(context)
                .textTheme
                .headline6!
                .copyWith(color: Colors.white),
      ),
    );
  }
}
