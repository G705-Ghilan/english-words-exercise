import 'dart:convert';
import 'dart:io';

import 'package:english_words_exercise/modules/initial_data.dart';
import 'package:english_words_exercise/source/constance.dart';
import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';

class WordsPageInformation {
  final String title;
  // final String subTitle;
  final String wordsTitle;
  List<dynamic>? words;
  final Color circularProgressColor;

  WordsPageInformation(
      {required this.title,
      // required this.subTitle,
      required this.wordsTitle,
      required this.words,
      required this.circularProgressColor});
}

class AppProvider with ChangeNotifier {
  WordsPageInformation? activeWordsPageInformation;
  List<WordsPageInformation> allWordsPageInformation = [];
  Map<String, dynamic>? jsonData;
  late File dbFile;

  set setWordsPageInformationByIndex(int index) {
    activeWordsPageInformation = allWordsPageInformation[index];
    notifyListeners();
  }

  set setActivePageWordInformation(List<dynamic>? words) {
    activeWordsPageInformation!.words = words;
    notifyListeners();
  }

  set addWordsPageInformation(WordsPageInformation newWordsPageInformation) {
    allWordsPageInformation.add(newWordsPageInformation);
    notifyListeners();
  }

  void set addWordsFolder(data) {
    jsonData!["words-folders"]!.add(data);

    notifyListeners();
    saveData();
  }

  addWord(String folderName, Map<String, dynamic> data) {
    final int index = jsonData!["words-folders"]!.indexWhere((name) {
      print(name);
      return folderName == name['title'];
    });
    jsonData!["words-folders"]![index]["words"]!.add(data);

    notifyListeners();
    saveData();
    return jsonData!["words-folders"]![index]["words"]!;
  }

  Future<void> initialJsonData() async {
    CONSTANCE().initial();
    final Directory dir = await getApplicationDocumentsDirectory();
    dbFile = File([dir.path, "data.json"].join('/'));

    print("-------------------------------------------");
    saveData(data: initialData);
    if (dbFile.existsSync()) {
      jsonData = const JsonDecoder().convert(dbFile.readAsStringSync());
    } else {
      saveData(data: initialData);

      jsonData = initialData;
    }
  }

  void saveData({Map<String, dynamic>? data}) {
    print("save $jsonData");
    dbFile.writeAsStringSync(
      const JsonEncoder.withIndent("  ").convert(data ?? jsonData),
    );
  }

  get getJsonData {
    print("sdffffffffffffffffffffffffffff");
    return jsonData!['words-folders'];
  }
}
