import 'dart:math';

import 'package:english_words_exercise/modules/app_provider.dart';
import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/expanded_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:provider/provider.dart';

class CartPart extends StatefulWidget {
  const CartPart({super.key});

  @override
  State<CartPart> createState() => _CartPartState();
}

class _CartPartState extends State<CartPart> with TickerProviderStateMixin {
  bool arabic = false;
  late AnimationController animationController;
  int index = 0;

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: const Duration(seconds: 1));
  }

  @override
  void dispose() {
    super.dispose();
    animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final anime = Tween(begin: pi, end: 0).animate(animationController);
    final words =
        context.watch<AppProvider>().activeWordsPageInformation!.words!;
    final completed =
        "${words[index]['completed']} / ${words[index]['unCompleted']}";

    return Column(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(40),
          child: AnimatedBuilder(
            animation: anime,
            builder: (context, child) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationY(anime.value.toDouble()),
                child: child,
              );
            },
            child: Container(
                decoration: CONSTANCE.defaultDecoration,
                child: Material(
                  borderRadius: CONSTANCE.defaultBorderRadius,
                  color: Colors.white,
                  child: InkWell(
                    borderRadius: CONSTANCE.defaultBorderRadius,
                    onTap: () {
                      setState(() {
                        if (arabic) {
                          animationController.reverse();
                        } else {
                          animationController.forward();
                        }
                        arabic = !arabic;
                      });
                    },
                    child: Padding(
                      padding: CONSTANCE.defaultPadding,
                      child: AnimatedSwitcher(
                        duration: const Duration(seconds: 1),
                        switchOutCurve: Curves.easeInOutBack,
                        switchInCurve: Curves.easeInBack,
                        child: arabic
                            ? buildCartContent(words[index]['translate'],
                                "to arabic", completed)
                            : Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(pi),
                                child: buildCartContent(words[index]['title'],
                                    words[index]["note"], completed),
                              ),
                      ),
                    ),
                  ),
                )),
          ),
        )),
        Row(
          children: [
            Expanded(
              child: ExpandedButton(
                text: "BACK",
                isOutline: true,
                isAcive: index == 0 ? false : true,
                onTap: () {
                  setState(() {
                    if (index > 0) {
                      index--;
                    }
                  });
                },
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: ExpandedButton(
                text: index < words.length - 1 ? "PLAY" : "NEXT",
                isOutline: index < words.length - 1 ? true : false,
                onTap: () {
                  if (arabic) {
                    animationController.reverse();
                    setState(() => arabic = !arabic);
                  }
                  setState(() {
                    if (index < words.length - 1) index++;
                  });
                },
              ),
            )
          ],
        )
      ],
    );
  }

  Stack buildCartContent(String word, String note, percent) {
    return Stack(
      children: [
        Center(
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Text(
                word,
                style: CONSTANCE.itemTitleTextStyle,
              ),
              Text(
                note,
                style: CONSTANCE.itemSubTitleTextStyle,
              )
            ],
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Text(percent, style: CONSTANCE.itemSubTitleTextStyle),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Row(
            children: [
              const Spacer(),
              // IconButton(
              //   onPressed: () {},
              //   icon: const Icon(Icons.sports_volleyball_rounded),
              //   splashRadius: 23,
              // ),
              IconButton(
                onPressed: () {
                  CONSTANCE.flutterTts.speak(word);
                },
                icon: const Icon(Icons.volume_up_outlined),
                splashRadius: 23,
              ),
            ],
          ),
        )
      ],
    );
  }
}
