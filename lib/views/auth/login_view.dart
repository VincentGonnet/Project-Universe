import 'package:project_universe/services/auth/auth_exceptions.dart';
import 'package:project_universe/services/auth/bloc/auth_bloc.dart';
import 'package:project_universe/services/auth/bloc/auth_event.dart';
import 'package:project_universe/services/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project_universe/utilities/dialogs/error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateLoggedOut) {
          if (state.exception is UserNotFoundAuthException) {
            await showErrorDialog(context, 'User not found');
          } else if (state.exception is WrongPasswordAuthException) {
            await showErrorDialog(context, 'Wrong password');
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(context, 'Invalid email');
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(context, 'Authentication error');
          }
        }
      },
      child: Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Spacer(flex: 1),
                Container(
                  padding: const EdgeInsets.only(bottom: 30),
                  child: Text(
                    "Project Universe",
                    style: GoogleFonts.montserrat(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                ),
                TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    hintText: 'Enter your email here.',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    labelText: "Email",
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                  child: TextField(
                    controller: _password,
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      hintText: 'Enter your password here.',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                      ),
                      labelText: "Password",
                    ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    if (email == "" || password == "") {
                      return await showErrorDialog(
                          context, "Please specify an email and a password");
                    }
                    context
                        .read<AuthBloc>()
                        .add(AuthEventLogIn(email, password));
                  },
                  child: const Text("Login"),
                ),
                const Spacer(flex: 2),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventForgotPassword(),
                        );
                  },
                  child: const Text("Forgot password"),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(
                          const AuthEventShouldRegister(),
                        );
                  },
                  child: const Text("Not registered yet? Register here!"),
                ),
              ],
            ),
          )),
    );
  }
}
