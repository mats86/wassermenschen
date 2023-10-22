import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/parent_personal_info_bloc.dart';

class ParentPersonalInfoForm extends StatefulWidget {
  const ParentPersonalInfoForm({Key? key}) : super(key: key);

  @override
  State<ParentPersonalInfoForm> createState() => _ParentPersonalInfoForm();
}

class _ParentPersonalInfoForm extends State<ParentPersonalInfoForm> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<ParentPersonalInfoBloc, ParentPersonalInfoState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(content: Text('Something went wrong!')),
              );
          }
        },
      child: Column(
        children: [

        ],
      ),
    )
  }
}
