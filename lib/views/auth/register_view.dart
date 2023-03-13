import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_universe/constants/colors.dart';
import 'package:project_universe/services/auth/auth_exceptions.dart';
import 'package:project_universe/services/auth/bloc/auth_bloc.dart';
import 'package:project_universe/services/auth/bloc/auth_event.dart';
import 'package:project_universe/services/auth/bloc/auth_state.dart';
import 'package:project_universe/utilities/dialogs/error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _userName;
  late final TextEditingController _displayName;
  late final TextEditingController _password;

  Color _emailFieldColor = Colors.black45;
  Color _usernameFieldColor = Colors.black45;
  Color _displaynameFieldColor = Colors.black45;
  Color _passwordFieldColor = Colors.black45;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    _userName = TextEditingController();
    _displayName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    _userName.dispose();
    _displayName.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateRegistering) {
          if (state.exception is WeakPasswordAuthException) {
            await showErrorDialog(
              context,
              "Weak Password",
            );
          } else if (state.exception is EmailAlreadyInUseAuthException) {
            await showErrorDialog(
              context,
              "Email already in use",
            );
          } else if (state.exception is GenericAuthException) {
            await showErrorDialog(
              context,
              "An error occurred.",
            );
          } else if (state.exception is InvalidEmailAuthException) {
            await showErrorDialog(
              context,
              "Invalid email/",
            );
          }
        }
      },
      child: Scaffold(
        body: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Container(
                padding: const EdgeInsets.only(bottom: 30),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Sign Up",
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
                      HeroIcons.user,
                      color: Colors.black45,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Focus(
                        onFocusChange: (hasFocus) {
                          setState(() => _usernameFieldColor =
                              hasFocus ? loginAccentColor : Colors.black45);
                        },
                        child: TextField(
                          controller: _userName,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: "Username",
                            labelStyle: TextStyle(
                              color: _usernameFieldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    const HeroIcon(
                      HeroIcons.chatBubbleBottomCenter,
                      color: Colors.black45,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Focus(
                        onFocusChange: (hasFocus) {
                          setState(() => _displaynameFieldColor =
                              hasFocus ? loginAccentColor : Colors.black45);
                        },
                        child: TextField(
                          controller: _displayName,
                          keyboardType: TextInputType.name,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: "Display Name",
                            labelStyle: TextStyle(
                              color: _displaynameFieldColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: "Password",
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
                margin: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: loginAccentColor,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: () async {
                    final email = _email.text;
                    final password = _password.text;
                    final username = _userName.text;
                    final displayName = _displayName.text;
                    context.read<AuthBloc>().add(
                          AuthEventRegister(
                            email,
                            password,
                            username,
                            displayName,
                          ),
                        );
                  },
                  child: const Text(
                    "Register",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
              const Spacer(flex: 2),
              TextButton(
                onPressed: () {
                  context.read<AuthBloc>().add(
                        const AuthEventLogOut(),
                      );
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "Already have an account? "),
                      TextSpan(
                        text: "Login",
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
        ),
      ),
    );
  }
}
