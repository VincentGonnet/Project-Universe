import 'package:flutter/material.dart';
import 'package:project_universe/components/side_menu/side_menu.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    return SideMenu();
  }
}
