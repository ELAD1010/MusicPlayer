import "package:flutter/material.dart";

class SongImage extends StatelessWidget {
  final String imageUrl;
  const SongImage({Key? key, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image(
      width: MediaQuery.of(context).size.width * 0.8,
      image: NetworkImage(imageUrl),
    );
  }
}
