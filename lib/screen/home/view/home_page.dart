import 'dart:ui';
import 'package:bhagavad_gita_app/provider/main_provider.dart';
import 'package:bhagavad_gita_app/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MainProvider read = MainProvider();
  MainProvider watch = MainProvider();
  final Map<int, String> appBarTitles = {
    0: 'श्रीमद भगवद्‍ गीता',
    1: 'श्रीमद् भगवद्गीता',
    2: 'Srimad Bhagavad Gita',
    3: 'શ્રીમદ્ ભગવદ ગીતા',
  };

  @override
  void initState() {
    context.read<MainProvider>().getChapterData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    read = context.read<MainProvider>();
    watch = context.watch<MainProvider>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xff301b14),
        centerTitle: true,
        title: Text(
          appBarTitles[read.languageIndex] ?? '',
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButton<int>(
              value: read.languageIndex,
              dropdownColor: Colors.black87.withOpacity(0.6),
              icon: const Icon(Icons.language, color: Colors.white),
              underline: Container(color: Colors.white),
              style: const TextStyle(color: Colors.white),
              borderRadius: BorderRadius.circular(10),
              items: const [
                DropdownMenuItem(value: 0, child: Text("Sanskrit")),
                DropdownMenuItem(value: 1, child: Text("Hindi")),
                DropdownMenuItem(value: 2, child: Text("English")),
                DropdownMenuItem(value: 3, child: Text("Gujarati")),
              ],
              onChanged: (value) {
                read.setLanguageIndex(value!);
              },
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/bg/splash.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 2, sigmaY: 2),
              child: Container(
                color: Colors.black.withOpacity(0.3),
              ),
            ),
          ),
          ListView.builder(
            itemCount: read.chapterData.length,
            itemBuilder: (context, index) {
              final chapter = watch.chapterData[index];

              final chapterName = watch.languageIndex == 0
                  ? chapter.nameModel!.sanskrit
                  : watch.languageIndex == 1
                      ? chapter.nameModel!.hindi
                      : watch.languageIndex == 2
                          ? chapter.nameModel!.english
                          : chapter.nameModel!.gujarati;

              final chapterSubtitle = watch.languageIndex == 0
                  ? chapter.chapterNumberModel!.sanskrit
                  : watch.languageIndex == 1
                      ? chapter.chapterNumberModel!.hindi
                      : watch.languageIndex == 2
                          ? chapter.chapterNumberModel!.english
                          : chapter.chapterNumberModel!.gujarati;

              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                child: Container(
                  decoration: const BoxDecoration(color: Colors.transparent),
                  child: ListTile(
                    tileColor: Colors.transparent,
                    onTap: () {
                      read.getVersesForChapter(watch.chapterData[index].id!);
                      Navigator.pushNamed(
                        context,
                        AppRoutes.verses,
                        arguments: watch.chapterData[index],
                      );
                    },
                    leading: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.transparent.withOpacity(0),
                        // border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          chapter.id.toString(),
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      chapterName ?? '',
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    subtitle: Row(
                      children: [
                        const Icon(Icons.menu_book,
                            color: Colors.white, size: 18),
                        const SizedBox(width: 5),
                        Text(
                          chapterSubtitle ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
