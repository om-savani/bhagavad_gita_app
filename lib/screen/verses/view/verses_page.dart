import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:bhagavad_gita_app/provider/main_provider.dart';
import 'package:bhagavad_gita_app/model/data_model/chapter_model.dart';
import 'package:bhagavad_gita_app/routes/app_routes.dart';

class VersesPage extends StatefulWidget {
  const VersesPage({super.key});

  @override
  State<VersesPage> createState() => _VersesPageState();
}

class _VersesPageState extends State<VersesPage> {
  MainProvider read = MainProvider();
  MainProvider watch = MainProvider();

  @override
  void initState() {
    super.initState();
    context.read<MainProvider>().getVersesData();
  }

  @override
  Widget build(BuildContext context) {
    read = context.read<MainProvider>();
    watch = context.watch<MainProvider>();
    ChapterModel model =
        ModalRoute.of(context)!.settings.arguments as ChapterModel;

    final chapterVerses = watch.versesData
        .where((verse) => verse.chapter_number == model.id)
        .toList();

    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        centerTitle: true,
        backgroundColor: const Color(0xff301b14),
        title: Text(watch.getAppBarTitle(model)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/chapter_bg/${model.id}.jpg',
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
            itemCount: chapterVerses.length,
            itemBuilder: (context, index) {
              final verse = chapterVerses[index];
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
                  tileColor: Colors.transparent,
                  onTap: () {
                    Navigator.of(context).pushNamed(
                      AppRoutes.detail,
                      arguments: {'initialIndex': index},
                    );
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: Text(
                      "${verse.id}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  title: Text(
                    watch.getVerseTitle(verse),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
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
