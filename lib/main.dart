import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'constants/routes.dart';
import 'helpers/loading/loading_screen.dart';
import 'services/auth/bloc/auth_bloc.dart';
import 'services/auth/bloc/auth_event.dart';
import 'services/auth/bloc/auth_state.dart';
import 'services/auth/firebase_auth_provider.dart';
import 'views/auth/forgot_password.dart';
import 'views/auth/login_view.dart';
import 'views/auth/register_view.dart';
import 'views/auth/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project : Universe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Project : Universe',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());

    return BlocConsumer<AuthBloc, AuthState>(listener: (context, state) {
      if (state.isLoading) {
        LoadingScreen().show(
            context: context,
            text: state.loadingText ?? "Please wait a moment");
      } else {
        LoadingScreen().hide();
      }
    }, builder: (context, state) {
      if (state is AuthStateLoggedIn) {
        return const Text("Logged in");
      } else if (state is AuthStateNeedsVerification) {
        return const VerifyEmailView();
      } else if (state is AuthStateLoggedOut) {
        return const LoginView();
      } else if (state is AuthStateRegistering) {
        return const RegisterView();
      } else if (state is AuthStateForgotPassword) {
        return const ForgotPasswordView();
      } else {
        return const Scaffold(
          body: CircularProgressIndicator(),
        );
      }
    });
  }
}
