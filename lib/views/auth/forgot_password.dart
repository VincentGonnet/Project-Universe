import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heroicons/heroicons.dart';
import 'package:project_universe/services/auth/bloc/auth_bloc.dart';
import 'package:project_universe/services/auth/bloc/auth_event.dart';
import 'package:project_universe/services/auth/bloc/auth_state.dart';
import 'package:project_universe/utilities/dialogs/error_dialog.dart';
import 'package:project_universe/utilities/dialogs/password_reset_email_sent_dialog.dart';

import '../../constants/colors.dart';

class ForgotPasswordView extends StatefulWidget {
  const ForgotPasswordView({Key? key}) : super(key: key);

  @override
  ForgotPasswordViewState createState() => ForgotPasswordViewState();
}

class ForgotPasswordViewState extends State<ForgotPasswordView> {
  late final TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _emailFieldColor = Colors.black45;

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) async {
        if (state is AuthStateForgotPassword) {
          if (state.hasSentEmail) {
            _controller.clear();
            await showPasswordResetSentDialog(context);
          }
          if (state.exception != null) {
            if (mounted) {
              await showErrorDialog(context,
                  'We could not process your request. Please make sure that you are a registered user, or if not, register a user now by going back one step.');
            }
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
              const Spacer(flex: 1),
              Container(
                padding: const EdgeInsets.only(bottom: 20),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Forgot\nPassword?",
                  style: GoogleFonts.nunitoSans(
                    color: loginTitleColor,
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.only(bottom: 30),
                child: const Text(
                    'If you forgot your password, simply enter your email and we will send you a password reset link.',
                    style: TextStyle(
                      color: loginTitleColor,
                      fontSize: 16,
                    )),
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
                        controller: _controller,
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
                margin: const EdgeInsets.only(top: 30),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: loginAccentColor,
                    minimumSize: const Size(double.infinity, 40),
                  ),
                  onPressed: () async {
                    final email = _controller.text;
                    if (email == "") {
                      return await showErrorDialog(
                          context, "Please specify an email address");
                    }
                    context
                        .read<AuthBloc>()
                        .add(AuthEventForgotPassword(email: email));
                  },
                  child: const Text(
                    "Submit",
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
                        const AuthEventLogOut(),
                      );
                },
                child: RichText(
                  text: const TextSpan(
                    style: TextStyle(
                      color: Colors.black45,
                    ),
                    children: <TextSpan>[
                      TextSpan(text: "Back to "),
                      TextSpan(
                        text: "login page",
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
