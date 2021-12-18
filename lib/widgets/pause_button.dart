import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  final Function pauseSong;

  const PauseButton(this.pauseSong);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        color: Colors.grey,
        onPressed: () => pauseSong(),
        icon: const Icon(
          Icons.pause_circle,
          size: 46,
        ));
  }
}
