import 'package:flutter/material.dart';

class DownloadFinishedIcon extends StatelessWidget {
  const DownloadFinishedIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.download_done_rounded,
      color: Colors.grey,
      size: 46,
    );
  }
}
