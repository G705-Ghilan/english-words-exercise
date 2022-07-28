import 'package:english_words_exercise/modules/app_provider.dart';
import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/custom_word_page_maker/custom_word_page_maker.dart';
import 'package:english_words_exercise/source/widget/custom_word_page_maker/sliver_appbar_with_circular_indicator.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class CustomWordsFolderPage extends StatelessWidget {
  const CustomWordsFolderPage({super.key});

  @override
  Widget build(BuildContext context) {
    WordsPageInformation wordsPageInformation =
        context.watch<AppProvider>().activeWordsPageInformation!;
    print("${context.watch<AppProvider>().activeWordsPageInformation}");
    num completeds = 0;
    num unCompleteds = 0;
    for (Map<String, dynamic> word in wordsPageInformation.words!) {
      completeds += word['completed']!;
      unCompleteds += word['unCompleted'];
    }
    // completeds = 13;

    return Scaffold(
      body: CustomWordsPageMaker(
        sliverAppbarWithCircularIndicator: SliverAppbarWithCircularIndicator(
          title: wordsPageInformation.title,
          subTitle:
              "you have $completeds / $unCompleteds points\n${CONSTANCE.getJobState(completeds, unCompleteds).toUpperCase()} !",
          wordsTitle: wordsPageInformation.wordsTitle,
          precent: unCompleteds > 0
              ? [completeds / unCompleteds] 
              : [0, 0],
          circularProgressColor: wordsPageInformation.circularProgressColor,
          isShowPlayTestIconButton: true,
        ),
        words: null,
      ),
    );
  }
}
