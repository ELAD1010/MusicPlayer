import "package:flutter/material.dart";
import 'package:music_player/widgets/search_list.dart';

class SearchScreen extends StatelessWidget {
  final Function openNowPlaying;

  const SearchScreen({Key? key, required this.openNowPlaying})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SongList(
        openNowPlaying: openNowPlaying,
      ),
    );
  }
}
