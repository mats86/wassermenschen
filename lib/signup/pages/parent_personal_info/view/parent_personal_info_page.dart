import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'parent_personal_info_form.dart';

import '../bloc/parent_personal_info_bloc.dart';

class ParentPersonalInfoPage extends StatelessWidget {
  const ParentPersonalInfoPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
      builder: (_) => const ParentPersonalInfoPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => ParentPersonalInfoBloc(
          userRepository: context.read<UserRepository>(),
        ),
        child: const ParentPersonalInfoForm(),
      ),
    );
  }
}