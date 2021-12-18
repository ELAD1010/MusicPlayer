import 'package:flutter/material.dart';
import 'package:music_player/utils/save_audio.dart';
import 'package:provider/provider.dart';

import './screens/home_page.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Music Player', home: HomePage());
  }
}
