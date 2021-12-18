import 'package:flutter/material.dart';

class PlayButton extends StatelessWidget {
  final Function playSong;

  const PlayButton(this.playSong);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Colors.grey,
        onPressed: () => playSong(),
        icon: const Icon(
          Icons.play_circle,
          size: 46,
        ));
  }
}
