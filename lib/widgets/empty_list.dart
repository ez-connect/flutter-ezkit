import 'package:flutter/material.dart';

class EmptyList extends StatelessWidget {
  final Icon icon;
  final String description;

  const EmptyList({
    Key? key,
    required this.icon,
    required this.description,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          this.icon,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Text(this.description),
          ),
        ],
      ),
    );
  }
}
