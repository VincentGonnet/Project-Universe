import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.universeName,
  }) : super(key: key);

  final String universeName;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const CircleAvatar(
        backgroundColor: Colors.white24,
        child: Icon(
          Icons.settings,
          color: Colors.white,
        ),
      ),
      title: Text(
        universeName,
        style: const TextStyle(color: Colors.white),
      ),
    );
  }
}
