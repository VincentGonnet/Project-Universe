import 'package:flutter/material.dart';
import 'package:project_universe/components/side_menu/info_card.dart';
import 'package:project_universe/components/side_menu/side_menu_link.dart';

class SideBar extends StatefulWidget {
  const SideBar({super.key});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.blueGrey[900],
      child: Column(children: [
        Expanded(
          child: ListView(
            padding: EdgeInsets.zero,
            children: const [
              InfoCard(universeName: "World Name"),
              Divider(),
              SideMenuLink(name: "Players", icon: Icons.person),
              SideMenuLink(name: "NPCs", icon: Icons.group),
              SideMenuLink(
                  name: "World",
                  icon: IconData(0xe972, fontFamily: "RpgAwesome")),
              SideMenuLink(
                  name: "Bestiary",
                  icon: IconData(0xeaeb, fontFamily: "RpgAwesome")),
              // Expanded(child: SizedBox()),
            ],
          ),
        ),
        const SideMenuLink(name: "History", icon: Icons.history),
        const SideMenuLink(name: "Universe Settings", icon: Icons.settings),
      ]),
    );
  }
}
