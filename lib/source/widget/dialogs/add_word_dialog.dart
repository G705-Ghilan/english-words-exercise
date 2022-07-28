import 'package:english_words_exercise/modules/app_provider.dart';
import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/dialogs/dialog_text_field.dart';
import 'package:english_words_exercise/source/widget/expanded_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void showAddWordDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) {
        return const AddWordDialog();
      });
}

class AddWordDialog extends StatefulWidget {
  const AddWordDialog({super.key});

  @override
  State<AddWordDialog> createState() => _AddWordDialogState();
}

class _AddWordDialogState extends State<AddWordDialog> {
  List<List<dynamic>> textEditingControllers =
      List.generate(7, (index) => [false, TextEditingController()]);
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String word = '';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: CONSTANCE.defaultDialogTitlePosition("Add Word"),
      elevation: 0,
      contentPadding: CONSTANCE.defaultPadding,
      shape: CONSTANCE.defaultShape,
      content: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: Colors.black.withOpacity(0.5)),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 10,
              ),
              DialogTextField(
                labelText: "Word",
                hintText: "enjoy",
                textEditingController: textEditingControllers[0].last,
                validator: (p0) {
                  if (p0 == null) {
                    return "this field is required !";
                  } else if (textEditingControllers[0]
                          .last
                          .text
                          .trim()
                          .split(' ')
                          .length >
                      1) {
                    return "can't contains space!";
                  }
                },
              ),
              CONSTANCE.defaultHeightSpace,
              DialogTextField(
                labelText: "Note",
                hintText: "use it in school",
                textEditingController: textEditingControllers[1].last,
                maxLength: 30,
              ),
              CONSTANCE.defaultHeightSpace,

              Text(
                "Examples:",
                style: CONSTANCE.itemTitleTextStyle,
              ),
              // CONSTANCE.defaultHeightSpace,

              ...shortTextField(
                "Example 1",
                "they eat food",
                textEditingControllers[2].last,
              ),
              ...shortTextField(
                "Translate",
                "translate example 1 to arabic ...",
                textEditingControllers[3].last,
              ),
              ...shortTextField(
                "Example 2",
                "we eading food",
                textEditingControllers[4].last,
              ),
              ...shortTextField(
                "Example 3",
                "she eats food",
                textEditingControllers[5].last,
              ),

              CONSTANCE.defaultHeightSpace,
              ExpandedButton(
                text: "Add",
                onTap: () {
                  if (!formKey.currentState!.validate()) return;
                  context.read<AppProvider>().setActivePageWordInformation =
                      context.read<AppProvider>().addWord(
                          context
                              .read<AppProvider>()
                              .activeWordsPageInformation!
                              .title,
                          {
                        "title": textEditingControllers[0].last.text,
                        "note": textEditingControllers[1].last.text,
                        "examples": [
                          textEditingControllers[2].last.text,
                          textEditingControllers[4].last.text,
                          textEditingControllers[5].last.text,
                        ],
                        "translate": textEditingControllers[3].last.text,
                        "completed": 0,
                        "unCompleted": 4,
                        "isFavorite": false
                      });

                  // widget.set_state(() {});
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> shortTextField(String labelText, String hintText,
      TextEditingController textEditingController) {
    return [
      CONSTANCE.defaultHeightSpace,
      DialogTextField(
        labelText: labelText,
        hintText: hintText,
        maxLength: 30,
        textEditingController: textEditingController,
        onChanged: (p0) => setState(() {}),
        validator: (p0) {
          return p0 == null || p0.isEmpty ? "This field is Required" : null;
        },
      )
    ];
  }
}
