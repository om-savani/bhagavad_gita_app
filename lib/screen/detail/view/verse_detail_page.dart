import 'dart:ui';

import 'package:bhagavad_gita_app/provider/main_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VerseDetailPage extends StatefulWidget {
  final int initialIndex;

  const VerseDetailPage({super.key, required this.initialIndex});

  @override
  State<VerseDetailPage> createState() => _VerseDetailPageState();
}

class _VerseDetailPageState extends State<VerseDetailPage> {
  MainProvider read = MainProvider();
  MainProvider watch = MainProvider();
  late PageController pageController;
  late String verseText, verseTitle;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    read = context.read<MainProvider>();
    watch = context.watch<MainProvider>();
    final verse = watch.versesData[widget.initialIndex];
    String verseText = watch.getVerseText(verse);
    verseTitle = watch.getVerseTitle(verse);

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xff301b14),
        centerTitle: true,
        title: Text(watch.getVersePageAppBarTitle(verse.chapter_number!)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: PageView.builder(
        controller: pageController,
        itemCount: watch.versesData.length,
        itemBuilder: (context, index) {
          final verse = watch.versesData[index];
          final verseText = watch.getVerseText(verse);
          final verseTitle = watch.getVerseTitle(verse);

          return Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/bg/splash.jpg',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                  child: Container(
                    color: Colors.black.withOpacity(0.3),
                  ),
                ),
              ),
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.black.withOpacity(0.6),
                        Colors.black.withOpacity(0.4),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
              Center(
                child: Container(
                  width: 400,
                  height: 400,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    image: const DecorationImage(
                        image: AssetImage('assets/images/bg/verse_bg.jpg'),
                        fit: BoxFit.cover),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 65),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        verseTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        verseText,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 6,
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          print(verseText);
                          watch.speakText(verseText.toString());
                        },
                        icon: Icon(
                          watch.isSpeaking
                              ? Icons.pause_rounded
                              : Icons.play_arrow_rounded,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      // const Spacer(),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
