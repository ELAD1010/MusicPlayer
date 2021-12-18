import "package:flutter/material.dart";

class NextButton extends StatelessWidget {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      color: Colors.grey,
      onPressed: () {},
      icon: const Icon(Icons.skip_next, size: 46),
    );
  }
}
