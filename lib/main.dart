// ignore_for_file: use_build_context_synchronously

import 'package:firetest/constants/routes.dart';
import 'package:firetest/helpers/loading/loading_screen.dart';
import 'package:firetest/services/auth/bloc/auth_bloc.dart';
import 'package:firetest/services/auth/bloc/auth_event.dart';
import 'package:firetest/services/auth/bloc/auth_state.dart';
import 'package:firetest/services/auth/firebase_auth_provider.dart';
import 'package:firetest/views/forgot_password_view.dart';
import 'package:firetest/views/login_view.dart';
import 'package:firetest/views/notes/create_update_note_view.dart';
import 'package:firetest/views/notes/notes_view.dart';
import 'package:firetest/views/register_view.dart';
import 'package:firetest/views/verify_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider<AuthBloc>(
        create: (context) => AuthBloc(FirebaseAuthProvider()),
        child: const HomePage(),
      ),
      routes: {
        createOrUpdateNoteRoute: (context) => const CreateUpdateNoteView(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<AuthBloc>().add(const AuthEventInitialize());
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.isLoading) {
          LoadingScreen().show(
            context: context,
            text: state.loadingText ?? "Please wait a moment...",
          );
        } else {
          LoadingScreen().hide();
        }
      },
      builder: (context, state) {
        if (state is AuthStateLoggedIn) {
          return const NotesView();
        } else if (state is AuthStateNeedsVerification) {
          return const VerifyEmailView();
        } else if (state is AuthStateLoggedOut) {
          return const LoginView();
        } else if (state is AuthStateForgotPassword) {
          return const ForgotPasswordView();
        } else if (state is AuthStateRegistering) {
          return const RegisterView();
        } else {
          return const Scaffold(
            body: CircularProgressIndicator(),
          );
        }
      },
    );
  }
}

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   late final TextEditingController _controller;

//   @override
//   void initState() {
//     _controller = TextEditingController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => CounterBloc(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text("Testing Bloc"),
//           backgroundColor: Colors.blue,
//         ),
//         body: BlocConsumer<CounterBloc, CounterState>(
//           listener: (context, state) {
//             _controller.clear();
//           },
//           builder: (context, state) {
//             final invalidValue =
//                 (state is CounterStateInvalidNumber) ? state.invalidValue : "";
//             return Column(
//               children: [
//                 Text("Current value => ${state.value}"),
//                 Visibility(
//                   visible: state is CounterStateInvalidNumber,
//                   child: Text("Invalid input: $invalidValue"),
//                 ),
//                 TextField(
//                   controller: _controller,
//                   decoration: const InputDecoration(
//                     hintText: "Enter a number here",
//                   ),
//                   keyboardType: TextInputType.number,
//                 ),
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(DecrementEvent(_controller.text));
//                       },
//                       child: const Text("-"),
//                     ),
//                     TextButton(
//                       onPressed: () {
//                         context
//                             .read<CounterBloc>()
//                             .add(IncrementEvent(_controller.text));
//                       },
//                       child: const Text("+"),
//                     ),
//                   ],
//                 )
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }
// }

// @immutable
// abstract class CounterState {
//   final int value;

//   const CounterState(this.value);
// }

// class CounterStateValid extends CounterState {
//   const CounterStateValid(int value) : super(value);
// }

// class CounterStateInvalidNumber extends CounterState {
//   final String invalidValue;
//   const CounterStateInvalidNumber({
//     required this.invalidValue,
//     required int previousValue,
//   }) : super(previousValue);
// }

// @immutable
// abstract class CounterEvent {
//   final String value;
//   const CounterEvent(this.value);
// }

// class IncrementEvent extends CounterEvent {
//   const IncrementEvent(String value) : super(value);
// }

// class DecrementEvent extends CounterEvent {
//   const DecrementEvent(String value) : super(value);
// }

// class CounterBloc extends Bloc<CounterEvent, CounterState> {
//   CounterBloc() : super(const CounterStateValid(0)) {
//     on<IncrementEvent>(
//       (event, emit) {
//         final integer = int.tryParse(event.value);
//         if (integer == null) {
//           emit(CounterStateInvalidNumber(
//             invalidValue: event.value,
//             previousValue: state.value,
//           ));
//         } else {
//           emit(CounterStateValid(state.value + integer));
//         }
//       },
//     );
//     on<DecrementEvent>(
//       (event, emit) {
//         final integer = int.tryParse(event.value);
//         if (integer == null) {
//           emit(CounterStateInvalidNumber(
//             invalidValue: event.value,
//             previousValue: state.value,
//           ));
//         } else {
//           emit(CounterStateValid(state.value - integer));
//         }
//       },
//     );
//   }
// }
