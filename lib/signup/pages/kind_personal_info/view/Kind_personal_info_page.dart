import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

import '../bloc/kind_personal_info_bloc.dart';
import 'kind_personal_info_form.dart';

class KindPersonalInfoPage extends StatelessWidget {
  const KindPersonalInfoPage({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute<void>(
        builder: (_) => const KindPersonalInfoPage(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12.0),
      child: BlocProvider(
        create: (context) => KindPersonalInfoBloc(
            userRepository: context.read<UserRepository>(),
        ),
        child: const KindPersonalInfoForm(),
      ),
    );
  }
}