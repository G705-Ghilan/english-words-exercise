import 'package:english_words_exercise/modules/app_provider.dart';
import 'package:english_words_exercise/source/constance.dart';
import 'package:english_words_exercise/source/pages/custom_words_folder_page.dart';
import 'package:english_words_exercise/source/pages/home_page.dart';
import 'package:english_words_exercise/source/pages/test_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  AppProvider appProvider = AppProvider();
  await appProvider.initialJsonData();

  runApp(
    ChangeNotifierProvider(
      create: (ctx) => appProvider,
      child: const EnglishWordsExercise(),
    ),
  );
}

class EnglishWordsExercise extends StatelessWidget {
  const EnglishWordsExercise({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    FlutterNativeSplash.remove();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: CONSTANCE.homePage,
      routes: {
        CONSTANCE.homePage: (context) => const HomePage(),
        CONSTANCE.testPage: (context) => const TestPage(),
        CONSTANCE.customWordsFolderPage: (context) =>
            const CustomWordsFolderPage()
      },
    );
  }
}
