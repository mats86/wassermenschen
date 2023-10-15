import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'package:wassermenschen/signup/view/signup_stepper.dart';

import '../cubit/signup_cubit.dart';

class SignupPage extends StatelessWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<UserRepository>(
        create: (_) => UserRepository(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Anmelden'),
          centerTitle: true,
        ),
        body: BlocProvider<SignupCubit>(
          create: (_) => SignupCubit(5),
          child: const SignupStepper(),
        ),
      ),
    );
  }
}