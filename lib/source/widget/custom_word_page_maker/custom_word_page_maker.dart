import 'package:english_words_exercise/modules/app_provider.dart';
import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/dialogs/add_word_dialog.dart';
import 'package:english_words_exercise/source/widget/dialogs/add_words_folder_dialog.dart';
import 'package:english_words_exercise/source/widget/custom_word_page_maker/words_folder_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'word_item.dart';
import 'sliver_appbar_with_circular_indicator.dart';

class CustomWordsPageMaker extends StatefulWidget {
  final SliverAppbarWithCircularIndicator? sliverAppbarWithCircularIndicator;
  List<dynamic>? words;
  final bool isMainPage;

  CustomWordsPageMaker({
    super.key,
    required this.sliverAppbarWithCircularIndicator,
    this.words,
    this.isMainPage = false,
  });

  @override
  State<CustomWordsPageMaker> createState() => _CustomWordsPageMakerState();
}

class _CustomWordsPageMakerState extends State<CustomWordsPageMaker> {
  @override
  Widget build(BuildContext context) {
    widget.words = widget.words ?? getWords(context);
    return _buildContentPage(
      context,
      widget.sliverAppbarWithCircularIndicator ??
          getSliverAppbarWithCircularIndicator,
    );
  }

  CustomScrollView _buildContentPage(
      BuildContext context,
      SliverAppbarWithCircularIndicator
          notNullSliverAppbarWithCircularIndicator) {
    return CustomScrollView(
      slivers: [
        notNullSliverAppbarWithCircularIndicator,
        SliverToBoxAdapter(
          child: Container(
            height: 20,
            // color: Colors.green,
          ),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            generateWords(context)
              ..add(
                WordsFolderItem(
                  title: "Add title",
                  subTitle: "add subtitle",
                  completed: 0,
                  unCompleted: 0,
                  primaryItemColor: Colors.red,
                  isAdd: true,
                  onTap: () {
                    widget.isMainPage
                        ? showAddWordsFolderDialog(context)
                        : showAddWordDialog(context);
                    // setState(() {});
                  },
                ),
              ),
          ),
        )
      ],
    );
  }

  SliverAppbarWithCircularIndicator get getSliverAppbarWithCircularIndicator {
    num completeds = 0;
    num unCompleteds = 0;
    for (Map<String, dynamic> folder in widget.words!) {
      for (Map<String, dynamic> word in folder['words']!) {
        completeds += word['completed']!;
        unCompleteds++;
      }
    }

    return SliverAppbarWithCircularIndicator(
      title: "HOME",
      subTitle:
          "You saved  $completeds / $unCompleteds  words\n${CONSTANCE.getJobState(completeds, unCompleteds).toUpperCase()} !",
      wordsTitle: "Categories",
      precent: [completeds, unCompleteds],
      circularProgressColor: Color(0xFFFF00ED),
    );
  }

  List<dynamic> getWords(BuildContext context) {
    if (widget.isMainPage) {
      return context.watch<AppProvider>().jsonData!['words-folders'];
    }
    print('====');

    return context.watch<AppProvider>().activeWordsPageInformation!.words!;
  }

  List<Widget> generateWords(BuildContext context) {
    if (widget.words == null) {
      return [];
    }
    return List<Widget>.generate(widget.words?.length ?? 0, (int i) {
      if (widget.isMainPage) {
        return addWordsFolder(context, i);
      }
      return addWord(context, i);
    });
  }

  WordItem addWord(BuildContext context, int i) {
    return WordItem(
        title: widget.words![i]['title'],
        note: widget.words![i]['note'],
        completed: widget.words![i]['completed'],
        unCompleted: widget.words![i]['unCompleted'],
        primaryPageColor: context
            .watch<AppProvider>()
            .activeWordsPageInformation!
            .circularProgressColor);
  }

  Widget addWordsFolder(BuildContext context, int i) {
    List<num> completeValues =
        CONSTANCE.getPrecentByWords(widget.words![i]['words']!);
    // print(completeValues);
    WidgetsBinding.instance.addPostFrameCallback(
      (timeStamp) {
        if (context.read<AppProvider>().allWordsPageInformation.length >
            widget.words!.length) {
          print("ss");
          return;
        }
        print("**********");
        context.read<AppProvider>().addWordsPageInformation =
            WordsPageInformation(
          title: widget.words![i]['title'],
          wordsTitle: "All words",
          words: List<Map<String, dynamic>>.from(widget.words![i]['words']),
          circularProgressColor:
              Colors.primaries[widget.words![i]['primaryPageColorIndex']],
        );
      },
    );

    print(
        '${int.parse(completeValues[0].toString())}  ${int.parse(completeValues[1].toString())}');

    return WordsFolderItem(
      title: widget.words![i]['title'],
      subTitle: widget.words![i]['subTitle'],
      completed: completeValues[0].toInt(),
      unCompleted: completeValues[1].toInt(),
      primaryItemColor:
          Colors.primaries[widget.words![i]['primaryPageColorIndex']],
      onTap: () {
        context.read<AppProvider>().setWordsPageInformationByIndex = i;
        Navigator.pushNamed(context, CONSTANCE.customWordsFolderPage);
      },
    );
  }
}
