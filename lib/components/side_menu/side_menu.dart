import 'package:flutter/material.dart';
import 'package:project_universe/components/side_menu/info_card.dart';

class SideMenu extends StatefulWidget {
  const SideMenu({super.key});

  @override
  State<SideMenu> createState() => _SideMenuState();
}

class _SideMenuState extends State<SideMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: 288,
          height: double.infinity,
          color: const Color(0xFF17203A),
          child: SafeArea(
            child: Column(children: [
              const InfoCard(
                universeName: "Ecorcia",
              ),
              ListTile(
                leading: SizedBox(
                  height: 34,
                  width: 34,
                  child: Icon(
                    Icons.group,
                    color: Colors.white,
                  ),
                ),
                title: const Text(
                  "Players",
                  style: TextStyle(color: Colors.white),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
