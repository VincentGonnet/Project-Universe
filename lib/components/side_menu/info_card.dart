import 'package:flutter/material.dart';

class InfoCard extends StatelessWidget {
  const InfoCard({
    Key? key,
    required this.universeName,
  }) : super(key: key);

  final String universeName;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 162,
      decoration: const BoxDecoration(
        color: Colors.blue,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(2),
          bottomRight: Radius.circular(2),
        ),
      ),
      alignment: Alignment.bottomLeft,
      child: ListTile(
        title: Text(
          universeName,
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }
}
