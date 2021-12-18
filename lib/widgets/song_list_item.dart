import '../classes/song_object.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// List item representing a single Character with its photo and name.
class SongListItem extends StatelessWidget {
  const SongListItem({
    required this.song,
    required this.openNowPlaying,
    Key? key,
  }) : super(key: key);

  final Song song;
  final Function openNowPlaying;

  @override
  Widget build(BuildContext context) => ListTile(
        leading: Image.network(song.thumbnail),
        title: Text(song.title),
        subtitle: Text(song.artist),
        onTap: () => openNowPlaying(song),
      );
}
