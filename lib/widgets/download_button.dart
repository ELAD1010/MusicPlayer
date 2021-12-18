import 'package:flutter/material.dart';

class DownloadButton extends StatelessWidget {
  final Function downloadSong;
  const DownloadButton({Key? key, required this.downloadSong})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.grey,
      onPressed: () => downloadSong(),
      icon: const Icon(Icons.download_for_offline_rounded, size: 46),
    );
  }
}
