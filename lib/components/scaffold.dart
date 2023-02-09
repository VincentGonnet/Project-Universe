import 'package:flutter/material.dart';
import 'package:project_universe/components/appbar.dart';
import 'package:project_universe/components/side_menu/sidebar.dart';

class CustomScaffold extends StatelessWidget {
  const CustomScaffold({
    super.key,
    required this.displayName,
    required this.body,
  });

  final String displayName;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(appBarText: displayName),
      drawer: const SideBar(),
      body: body,
    );
  }
}
