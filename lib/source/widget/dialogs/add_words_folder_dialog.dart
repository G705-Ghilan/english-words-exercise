import 'package:english_words_exercise/modules/app_provider.dart';
import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/widget/dialogs/dialog_text_field.dart';
import 'package:english_words_exercise/source/widget/expanded_button.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

int getColor(BuildContext context) {
  const List<Color> primaries = Colors.primaries;
  num index = context.read<AppProvider>().jsonData!["words-folders"]!.length %
      primaries.length;
  return primaries.indexOf(primaries[index.toInt()]);
}

void showAddWordsFolderDialog(BuildContext context) {
  showDialog(
      context: context,
      builder: (ctx) {
        final TextEditingController folderNameTextEditingController =
            TextEditingController();
        final TextEditingController descriptionfolderNameTextEditingController =
            TextEditingController();

        return SimpleDialog(
          shape: CONSTANCE.defaultShape,
          elevation: 0,
          title: CONSTANCE.defaultDialogTitlePosition("Create folder"),
          contentPadding: CONSTANCE.defaultPadding,
          children: [
            Divider(color: Colors.black.withOpacity(0.5)),
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.4, height: 10),
            DialogTextField(
              textEditingController: folderNameTextEditingController,
              hintText: "Local words",
              labelText: "Folder Name",
              maxLength: 20,
            ),
            CONSTANCE.defaultHeightSpace,
            DialogTextField(
              textEditingController: descriptionfolderNameTextEditingController,
              hintText: "time, days, months words",
              labelText: "Description",
              maxLength: 30,
            ),
            CONSTANCE.defaultHeightSpace,
            ExpandedButton(
              text: "Create",
              onTap: () {
                context.read<AppProvider>().addWordsFolder = {
                  "title": folderNameTextEditingController.text,
                  "subTitle": descriptionfolderNameTextEditingController.text,
                  "completed": 0,
                  "primaryPageColorIndex": getColor(context),
                  "words": []
                };
                // setState(() {});
                Navigator.pop(context);
              },
            )
          ],
        );
      });
}
