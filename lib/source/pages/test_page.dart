import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/test_page_parts/cart_part.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  bool isLinearVisible = false;
  int completeds = 0;
  List<Widget> parts = [CartPart()];

  @override
  Widget build(BuildContext context) {
    Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Padding(
            padding: CONSTANCE.defaultPadding,
            child: LinearPercentIndicator(
              backgroundColor: CONSTANCE.primaryColor.withOpacity(0.2),
              progressColor: CONSTANCE.primaryColor,
              percent: completeds / arguments['percent'] > 0
                  ? completeds / arguments['percent']
                  : 0 / 1,
              lineHeight: 30,
              animation: true,
              barRadius: const Radius.circular(20),
            ),
          ),
          Text(
            "$completeds / ${arguments['percent']}",
            style: CONSTANCE.itemSubTitleTextStyle,
          ),
          Stack(
            alignment: Alignment.center,
            children: [
              Divider(
                color: Colors.black.withOpacity(0.5),
              ),
              Visibility(
                visible: isLinearVisible,
                child: Padding(
                  padding: const EdgeInsets.only(top: 2),
                  child: LinearPercentIndicator(
                    percent: 1,
                    lineHeight: 2,
                    animation: true,
                    animationDuration: 2000,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: Padding(
              padding: CONSTANCE.defaultPadding,
              child: (parts[0]),
            ),
          )
        ],
      )),
    );
  }
}
