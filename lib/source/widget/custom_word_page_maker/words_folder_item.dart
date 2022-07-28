import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/custom_word_page_maker/circular_indicator.dart';
import 'package:flutter/material.dart';

class WordsFolderItem extends StatelessWidget {
  final String title, subTitle;
  final int completed, unCompleted;
  final Color primaryItemColor;
  final void Function()? onTap;

  final bool isAdd;
  const WordsFolderItem(
      {super.key,
      required this.onTap,
      required this.title,
      required this.subTitle,
      required this.completed,
      required this.unCompleted,
      required this.primaryItemColor,
      this.isAdd = false,
      });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CONSTANCE.defaultPadding,
      decoration: CONSTANCE.defaultDecoration,
      child: Material(
        color: Colors.transparent,
        borderRadius: CONSTANCE.defaultBorderRadius,
        child: InkWell(
          // splashColor: primaryItemColor.withOpacity(0.4),
          borderRadius: CONSTANCE.defaultBorderRadius,
          onTap: onTap,
          child: Padding(
            padding: CONSTANCE.defaultPadding,
            child: isAdd
                ? Container(
                    height: 80,
                    alignment: Alignment.center,
                    child: const Icon(
                      Icons.add,
                      size: 40,
                    ),
                  )
                : contentItem(unCompleted > 0 ? completed / unCompleted : 0),
          ),
        ),
      ),
    );
  }

  contentItem(double precent) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        Row(
          children: [
            CircularIndicator(
              precent: precent,
              progressColor: primaryItemColor,
              backgroundColor: primaryItemColor.withOpacity(0.2),
              radius: 40,
              isItem: true,
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
              
                      Text(
                        title,
                        style: CONSTANCE.itemTitleTextStyle,
                      ),
                      
                  const SizedBox(height: 10),
            
                      Text(
                        subTitle * 2,
                        style: CONSTANCE.itemSubTitleTextStyle,
                      ),
                    
                ],
              ),
            )
          ],
        ),
      Text('$completed / $unCompleted',
            style: CONSTANCE.itemSubTitleTextStyle)
      ],
    );
  }

 
}
