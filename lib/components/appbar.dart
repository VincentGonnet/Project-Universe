// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project_universe/utilities/dialogs/logout_dialog.dart';

import '../services/auth/bloc/auth_bloc.dart';
import '../services/auth/bloc/auth_event.dart';
import '../enums/menu_action.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.appBarText});

  final String appBarText;

  @override
  Widget build(BuildContext context) {
    return AppBar(
        centerTitle: true,
        title: Text(
          appBarText,
        ),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  context.read<AuthBloc>().add(const AuthEventLogOut());
                } else {
                  return;
                }
                break;
            }
          }, itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                  value: MenuAction.logout, child: Text("Logout"))
            ];
          })
        ]);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
