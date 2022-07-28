import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/custom_word_page_maker/circular_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:like_button/like_button.dart';

class WordItem extends StatelessWidget {
  final String title, note;

  final int completed, unCompleted;
  final Color primaryPageColor;
  const WordItem(
      {super.key,
      required this.title,
      required this.note,
      required this.completed,
      required this.unCompleted,
      required this.primaryPageColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: CONSTANCE.defaultPadding,
      decoration: CONSTANCE.defaultDecoration,
      child: Material(
        borderRadius: CONSTANCE.defaultBorderRadius,
        color: Colors.transparent,
        child: InkWell(
          borderRadius: CONSTANCE.defaultBorderRadius,
          onTap: () {},
          child: Padding(
            padding: CONSTANCE.defaultPadding,
            child: contentItem(),
          ),
          // child: ,
        ),
      ),
    );
  }

  Column contentItem() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            CircleAvatar(
              radius: 8,
              backgroundColor: getisSavedAndColor(true),
            ),
            const SizedBox(width: 7),
            Text(
              getisSavedAndColor(false),
              style: CONSTANCE.isSavedWordTextStyle,
            ),
            const Spacer(),
            staredButton()
          ],
        ),
        const SizedBox(height: 7),
        Text(
          title,
          style: CONSTANCE.itemTitleTextStyle,
        ),
        const SizedBox(width: 20),
        Row(
          children: [
            Expanded(
              child: Text(
                note,
                style: CONSTANCE.itemSubTitleTextStyle,
              ),
            ),
            // Spacer(),
            Text("$completed / $unCompleted",
                style: CONSTANCE.itemSubTitleTextStyle)
          ],
        )
      ],
    );
  }

  InkWell staredButton() {
    return InkWell(
      borderRadius: CONSTANCE.defaultBorderRadius,
      child: LikeButton(
        circleColor: CircleColor(
            start: CONSTANCE.primaryColor,
            end: CONSTANCE.primaryColor.withOpacity(0.2)),
        bubblesColor: BubblesColor(
          dotPrimaryColor: CONSTANCE.primaryColor,
          dotSecondaryColor: primaryPageColor,
        ),
        likeBuilder: (bool isLiked) {
          return Icon(
            isLiked ? Icons.star : Icons.star_border,
            color: isLiked ? primaryPageColor : Colors.grey,
          );
        },
      ),
      onTap: () {},
    );
  }

  dynamic getisSavedAndColor(bool isColor) {
    if (completed == 0 || completed < unCompleted / 2) {
      return isColor ? Colors.red : "Unsaved";
    } else if (completed >= (unCompleted / 2) && completed != unCompleted) {
      return isColor ? Colors.yellow : "Average";
    } else {
      return isColor ? CONSTANCE.primaryColor : "Saved";
    }
  }
}
