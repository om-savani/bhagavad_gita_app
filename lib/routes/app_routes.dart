import 'package:bhagavad_gita_app/screen/home/view/home_page.dart';
import 'package:bhagavad_gita_app/screen/verses/view/verses_page.dart';
import 'package:flutter/material.dart';

import '../screen/detail/view/verse_detail_page.dart';
import '../screen/splash/view/splash_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String home = '/home';
  static const String verses = '/verses';
  static const String detail = '/detail';

  static Map<String, WidgetBuilder> routes = {
    splash: (context) => const SplashScreen(),
    home: (context) => const HomePage(),
    verses: (context) => const VersesPage(),
    detail: (context) {
      final arguments = ModalRoute.of(context)?.settings.arguments as Map?;
      final initialIndex = arguments?['initialIndex'] ?? 0;
      return VerseDetailPage(initialIndex: initialIndex);
    },
  };
}
