import 'package:flutter/material.dart';

class SideMenuLink extends StatelessWidget {
  const SideMenuLink({
    Key? key,
    required this.name,
    required this.icon,
  }) : super(key: key);

  final String name;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SizedBox(
        height: 44,
        width: 44,
        child: Icon(
          icon,
          color: Colors.white,
        ),
      ),
      title: Text(
        name,
        style: const TextStyle(color: Colors.white, fontSize: 18),
      ),
      visualDensity: const VisualDensity(vertical: 2),
    );
  }
}
