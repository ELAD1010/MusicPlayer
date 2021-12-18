import "package:flutter/material.dart";

class PreviousButton extends StatelessWidget {
  const PreviousButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.grey,
      onPressed: () {},
      icon: const Icon(Icons.skip_previous, size: 46),
    );
  }
}
