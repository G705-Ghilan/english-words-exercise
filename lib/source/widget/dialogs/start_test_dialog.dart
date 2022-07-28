import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/expanded_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showStartTestDialog(BuildContext context,Map<String,dynamic> arguments) {
  showDialog(
      context: context,
      builder: (ctx) {
        return  StartTestDialog(arguments: arguments,);
      });
}

class StartTestDialog extends StatefulWidget {
  final Map<String,dynamic> arguments;
  const StartTestDialog({super.key, required this.arguments});

  @override
  State<StartTestDialog> createState() => _StartTestDialogState();
}

class _StartTestDialogState extends State<StartTestDialog> {
  
  final List<List<String>> levels = [
    ["Cards", "see word and guss what deos it mean"],
    ["Translate", "translate from arabic to english"],
    ["Listen and write", "Listen to the words and then write it"],
    ["speak", "Speak the words"]
  ];
  List<bool> select = [true, false, false];

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: CONSTANCE.defaultDialogTitlePosition("Play test"),
      shape: CONSTANCE.defaultShape,
      contentPadding: CONSTANCE.defaultPadding,
      elevation: 0,
      children: [
        Divider(color: Colors.black.withOpacity(0.5)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildGroupButton("01:10 time", 0),
            _buildGroupButton("00:50 time", 1),
            _buildGroupButton("Infinte time", 2),
          ],
        ),
        SizedBox(
          child: _buildList(),
          width: double.maxFinite,
        ),
        CONSTANCE.defaultHeightSpace,
        ExpandedButton(
          text: "Play",
          onTap: () {
            Navigator.pop(context);
            Navigator.pushNamed(context, CONSTANCE.testPage, arguments: widget.arguments);
          },
        )
      ],
    );
  }

  _buildList() {
    return ReorderableListView(
      shrinkWrap: true,
      children: [
        for (List<String> level in levels)
          Padding(
            key: ValueKey(level.first),
            padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
            child: ListTile(
              shape: RoundedRectangleBorder(
                side:
                    BorderSide(width: 1, color: Colors.black.withOpacity(0.5)),
                borderRadius: CONSTANCE.defaultBorderRadius,
              ),
              style: ListTileStyle.drawer,
              subtitle: Text(level.last),
              title: Text(level.first),
              trailing: const Icon(Icons.menu),
            ),
          )
      ],
      onReorder: (oldIndex, newIndex) {
        setState(
          () => levels.insert(newIndex > oldIndex ? --newIndex : newIndex,
              levels.removeAt(oldIndex)),
        );
      },
    );
  }

  Widget _buildGroupButton(String text, int index) {
    return Material(
      color: Colors.transparent,
      borderRadius: CONSTANCE.defaultBorderRadius,
      child: InkWell(
          onTap: () {
            setState(() {
              select = List<bool>.filled(3, false);
              select[index] = true;
            });
          },
          borderRadius: CONSTANCE.defaultBorderRadius,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            padding: CONSTANCE.defaultPadding,
            decoration: BoxDecoration(
              color: select[index] ? CONSTANCE.primaryColor : null,
              border: Border.all(width: 1, color: CONSTANCE.primaryColor),
              borderRadius: CONSTANCE.defaultBorderRadius,
            ),
            child: Text(
              text,
              style: TextStyle(
                fontSize: 15,
                color: select[index] ? Colors.white : CONSTANCE.primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          )),
    );
  }
}
