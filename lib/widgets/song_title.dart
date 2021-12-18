import "package:flutter/material.dart";

class SongTitle extends StatelessWidget {
  final String title;
  final String subtitle;
  const SongTitle({Key? key, required this.title, required this.subtitle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey.withOpacity(0.6), fontSize: 24),
        )
      ],
    );
  }
}
