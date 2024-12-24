import 'package:bhagavad_gita_app/model/data_model/chapter_model.dart';
import 'package:bhagavad_gita_app/model/data_model/verses_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';

import '../helper/data_helper.dart';

class MainProvider with ChangeNotifier {
  List<ChapterModel> chapterData = [];
  List<VersesModel> versesData = [];
  DataHelper dataHelper = DataHelper();
  int languageIndex = 0;
  FlutterTts flutterTts = FlutterTts();
  bool isSpeaking = false;

  void setLanguageIndex(int index) {
    languageIndex = index;
    notifyListeners();
  }

  Future<void> getChapterData() async {
    chapterData = await dataHelper.chapterJsonParsing();
    notifyListeners();
  }

  Future<void> getVersesData() async {
    versesData = await dataHelper.versesJsonParsing();
    notifyListeners();
  }

  Future<void> getVersesForChapter(int id) async {
    versesData = await dataHelper.versesJsonParsing();
    versesData =
        versesData.where((verse) => verse.chapter_number == id).toList();
    notifyListeners();
  }

  String getChapterSummary(ChapterModel model) {
    switch (languageIndex) {
      case 0:
        return model.chapter_summary_sanskrit ?? "Summary unavailable";
      case 1:
        return model.chapter_summary_hindi ?? "Summary unavailable";
      case 2:
        return model.chapter_summary ?? "Summary unavailable";
      case 3:
        return model.chapter_summary_gujarati ?? "Summary unavailable";
      default:
        return model.chapter_summary_sanskrit ?? "Summary unavailable";
    }
  }

  String getAppBarTitle(ChapterModel model) {
    switch (languageIndex) {
      case 0:
        return "अध्याय ${model.id} के श्लोक";
      case 1:
        return "अध्याय ${model.id} के श्लोक";
      case 2:
        return "Verses of Chapter ${model.id}";
      case 3:
        return "અધ્યાય ${model.id} ના શ્લોક";
      default:
        return "अध्याय ${model.id} के श्लोक";
    }
  }

  String getChapterSummaryTitle(ChapterModel model) {
    switch (languageIndex) {
      case 0:
        return "अध्यायसारांशः ${model.id}";
      case 1:
        return "अध्याय ${model.id} का सारांश";
      case 2:
        return "Chapter ${model.id} Summary";
      case 3:
        return "પ્રકરણ ${model.id} સારાંશ";
      default:
        return "अध्यायसारांशः ${model.id}";
    }
  }

  String getVerseTitle(VersesModel verse) {
    switch (languageIndex) {
      case 0:
        return verse.titleModel?.sanskrit ?? "Title unavailable";
      case 1:
        return verse.titleModel?.hindi ?? "Title unavailable";
      case 2:
        return verse.titleModel?.english ?? "Title unavailable";
      case 3:
        return verse.titleModel?.gujarati ?? "Title unavailable";
      default:
        return verse.titleModel?.sanskrit ?? "Title unavailable";
    }
  }

  String getVerseText(VersesModel verse) {
    switch (languageIndex) {
      case 0:
        return verse.textModel?.sanskrit ?? "Verse text unavailable";
      case 1:
        return verse.textModel?.hindi ?? "Verse text unavailable";
      case 2:
        return verse.textModel?.english ?? "Verse text unavailable";
      case 3:
        return verse.textModel?.gujarati ?? "Verse text unavailable";
      default:
        return "Verse text unavailable";
    }
  }

  Future<void> speakText(String text) async {
    if (isSpeaking) {
      await flutterTts.stop();
    } else {
      await flutterTts.speak(text);
    }
    isSpeaking = !isSpeaking;
    notifyListeners();
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
    isSpeaking = false;
    notifyListeners();
  }

  String getVersePageAppBarTitle(int chapterId) {
    switch (languageIndex) {
      case 0:
        return "अध्याय $chapterId के श्लोक";
      case 1:
        return "अध्याय $chapterId के श्लोक";
      case 2:
        return "Verses of Chapter $chapterId";
      case 3:
        return "અધ્યાય $chapterId ના શ્લોક";
      default:
        return "अध्याय $chapterId के श्लोक";
    }
  }
}
