import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

class CONSTANCE {
  static late FlutterTts flutterTts;

  void initial() {
    flutterTts = FlutterTts();
    
  }

  static const Color primaryColor = Color(0xFF516BEB);

  static const EdgeInsets defaultPadding = EdgeInsets.all(10);
  static BorderRadius defaultBorderRadius = BorderRadius.circular(10);

  static const String homePage = "home_page";
  static const String testPage = "test_page";
  static const String customWordsFolderPage = "custom_words_folder_page";

  static TextStyle get itemTitleTextStyle {
    return const TextStyle(
      overflow: TextOverflow.ellipsis,
      fontWeight: FontWeight.bold,
      fontSize: 18,
    );
  }

  static TextStyle get itemSubTitleTextStyle {
    return const TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.black45,
    );
  }

  static TextStyle get itemPrecentTextSTyle {
    return const TextStyle(
      overflow: TextOverflow.ellipsis,
      color: Colors.black45,
      // fontWeight: FontWeight.bold,
      fontSize: 20,
    );
  }

  static TextStyle get isSavedWordTextStyle {
    return const TextStyle(
      overflow: TextOverflow.ellipsis,
      color: primaryColor,
      fontWeight: FontWeight.w300,
      fontSize: 11,
    );
  }

  static BoxDecoration get defaultDecoration {
    return BoxDecoration(
      border: Border.all(width: 1, color: Colors.black.withOpacity(0.5)),
      borderRadius: defaultBorderRadius,
    );
  }

  static getPrecentByWords(words) {
    num completeds = 0;
    num unCompleteds = 0;
    for (Map<String, dynamic> word in words) {
      completeds += word['completed']!;
      unCompleteds += word['unCompleted']!;
    }
    return [completeds, unCompleteds];
  }

  static String getJobState(num c, num unc) {
    if (unc == 0) {
      return "Start Learning 👨‍🎓";
    } else if (c < unc / 2) {
      return "Bad job 😑";
    } else if (c >= unc / 2 && !(c >= unc / 1.5)) {
      return "Good job 🙂";
    } else if (c >= unc / 1.5 && c != unc) {
      return "Excellent 😍";
    } else {
      return "Perfect 😎";
    }
  }

  static RoundedRectangleBorder get defaultShape {
    return RoundedRectangleBorder(borderRadius: defaultBorderRadius);
  }

  static const defaultHeightSpace = SizedBox(height: 10);

  static Center defaultDialogTitlePosition(String title) {
    return Center(child: Text(title));
  }
}
