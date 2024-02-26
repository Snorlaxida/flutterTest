// ignore_for_file: use_build_context_synchronously

import 'package:firetest/constants/routes.dart';
import 'package:firetest/services/auth/auth_service.dart';
import 'package:firetest/services/auth/bloc/auth_bloc.dart';
import 'package:firetest/services/auth/bloc/auth_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
      ),
      body: Column(
        children: [
          const Text(
              "We have sent u an email verification. Please open it to verify your account."),
          const Text(
              "If u haven'n received a verification email yet, press the button below."),
          TextButton(
              onPressed: () {
                context
                    .read<AuthBloc>()
                    .add(const AuthEventSendEmailVerification());
              },
              child: const Text("Send email verification")),
          TextButton(
              onPressed: () async {
                context.read<AuthBloc>().add(const AuthEventLogOut());
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}
