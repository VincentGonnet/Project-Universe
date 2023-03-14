import 'package:heroicons/heroicons.dart';
import 'package:project_universe/services/auth/auth_exceptions.dart';
import 'package:project_universe/services/auth/bloc/auth_bloc.dart';
import 'package:project_universe/services/auth/bloc/auth_event.dart';
import 'package:project_universe/services/auth/bloc/auth_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:project_universe/utilities/dialogs/error_dialog.dart';

import '../../constants/colors.dart';

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

  Color _emailFieldColor = Colors.black45;
  Color _passwordFieldColor = Colors.black45;
  bool _isPasswordVisible = false;
  HeroIcon _passwordFieldIcon =
      HeroIcon(HeroIcons.eyeSlash, color: Colors.black45);

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
          // appBar: AppBar(
          //   title: const Text("Login"),
          // ),
          body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 1),
            Container(
              padding: const EdgeInsets.only(bottom: 30),
              alignment: Alignment.centerLeft,
              child: Text(
                "Login",
                style: GoogleFonts.nunitoSans(
                  color: loginTitleColor,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                const HeroIcon(
                  HeroIcons.atSymbol,
                  color: Colors.black45,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Focus(
                    onFocusChange: (hasFocus) {
                      setState(() => _emailFieldColor =
                          hasFocus ? loginAccentColor : Colors.black45);
                    },
                    child: TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(
                          color: _emailFieldColor,
                        ),
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(
                            color: loginAccentColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: Row(
                children: [
                  const HeroIcon(
                    HeroIcons.lockClosed,
                    color: Colors.black45,
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Focus(
                      onFocusChange: (hasFocus) {
                        setState(() => _passwordFieldColor =
                            hasFocus ? loginAccentColor : Colors.black45);
                      },
                      child: TextField(
                        controller: _password,
                        obscureText: !_isPasswordVisible,
                        enableSuggestions: false,
                        autocorrect: false,
                        decoration: InputDecoration(
                          labelText: "Password",
                          suffixIcon: TextButton(
                              onPressed: () {
                                setState(() {
                                  if (_isPasswordVisible) {
                                    _passwordFieldIcon = const HeroIcon(
                                      HeroIcons.eyeSlash,
                                      color: Colors.black45,
                                    );
                                  } else {
                                    _passwordFieldIcon = const HeroIcon(
                                      HeroIcons.eye,
                                      color: loginAccentColor,
                                    );
                                  }
                                  _isPasswordVisible = !_isPasswordVisible;
                                });
                              },
                              child: _passwordFieldIcon),
                          labelStyle: TextStyle(
                            color: _passwordFieldColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventForgotPassword(),
                      );
                },
                child: const Text(
                  "Forgot password?",
                  style: TextStyle(
                    color: loginAccentColor,
                  ),
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 30),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: loginAccentColor,
                  minimumSize: const Size(double.infinity, 40),
                ),
                onPressed: () async {
                  final email = _email.text;
                  final password = _password.text;
                  if (email == "" || password == "") {
                    return await showErrorDialog(
                        context, "Please specify an email and a password");
                  }
                  context.read<AuthBloc>().add(AuthEventLogIn(email, password));
                },
                child: const Text(
                  "Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            const Spacer(flex: 1),
            TextButton(
              onPressed: () {
                context.read<AuthBloc>().add(
                      const AuthEventShouldRegister(),
                    );
              },
              child: RichText(
                text: const TextSpan(
                  style: TextStyle(
                    color: Colors.black45,
                  ),
                  children: <TextSpan>[
                    TextSpan(text: "Don't have an account yet? "),
                    TextSpan(
                      text: "Sign up",
                      style: TextStyle(
                        color: loginAccentColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
