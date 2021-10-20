import 'package:flutter/material.dart';

class TagGenre extends StatelessWidget {
  const TagGenre({
    required this.label,
  });

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black12,
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.symmetric(horizontal: 2.5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Text(label),
    );
  }
}
