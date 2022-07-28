
import 'package:english_words_exercise/source/widget/custom_word_page_maker/custom_word_page_maker.dart';
import 'package:flutter/material.dart';

// import '';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 

    
  @override
  Widget build(BuildContext context) {
     
    return Scaffold(
      body: CustomWordsPageMaker(
      isMainPage: true,
      sliverAppbarWithCircularIndicator: null,
    )
    );
  }

  
    

    
  }

