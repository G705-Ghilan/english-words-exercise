import 'package:badges/badges.dart';
import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/custom_word_page_maker/circular_indicator.dart';
import 'package:english_words_exercise/source/widget/dialogs/start_test_dialog.dart';
import 'package:flutter/material.dart';

class SliverAppbarWithCircularIndicator extends StatelessWidget {
  final String title, subTitle, wordsTitle;
  final List<num> precent;
  final Color circularProgressColor;
  final bool isSplash;
  final bool isShowPlayTestIconButton;
  const SliverAppbarWithCircularIndicator({
    super.key,
    required this.title,
    required this.subTitle,
    required this.wordsTitle,
    required this.precent,
    required this.circularProgressColor,
    this.isSplash = false,
    this.isShowPlayTestIconButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      elevation: isSplash ? 0 : 10,
      automaticallyImplyLeading: false,
      forceElevated: true,
      collapsedHeight: kToolbarHeight,
      actions: [
        Badge(
          badgeContent: const SizedBox(height: 1, width: 1),
          showBadge: true,
          position: BadgePosition(end: 7, top: 8),
          child: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
            splashRadius: 25,
          ),
        ),
        isShowPlayTestIconButton
            ? IconButton(
                onPressed: () {
                  showStartTestDialog(context, {"percent": precent.last});
                },
                icon: const Icon(Icons.play_arrow_outlined),
                splashRadius: 25,
              )
            : const SizedBox()
      ],
      shadowColor: CONSTANCE.primaryColor,
      backgroundColor: isSplash ? Colors.transparent : CONSTANCE.primaryColor,
      expandedHeight: MediaQuery.of(context).size.height / 4,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(15)),
      ),
      flexibleSpace: FlexibleSpaceBar(
        title: Text(wordsTitle),
        collapseMode: CollapseMode.pin,
        titlePadding: const EdgeInsets.all(15),
        background: SafeArea(
          child: Padding(
            padding:
                const EdgeInsets.only(left: 25, right: 25, top: 25, bottom: 65),
            child: FittedBox(
              alignment: Alignment.centerLeft,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircularIndicator(
                    precent: precent.first / precent.last,
                    progressColor: circularProgressColor,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: Theme.of(context)
                              .textTheme
                              .headline4!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          subTitle,
                          style: Theme.of(context).textTheme.caption!.copyWith(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.9),
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
