import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker_plus/flutter_datetime_picker_plus.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';
import '../../../cubit/signup_cubit.dart';

import '../bloc/kind_personal_info_bloc.dart';

class KindPersonalInfoForm extends StatefulWidget {
  const KindPersonalInfoForm({Key? key}) : super(key: key);

  @override
  State<KindPersonalInfoForm> createState() =>_KindPersonalInfoForm();
}

class _KindPersonalInfoForm extends State<KindPersonalInfoForm> {
  
  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return BlocListener<KindPersonalInfoBloc, KindPersonalInfoState>(
        listener: (context, state) {
          if(state.status.isSubmissionFailure) {
            ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Something went wrong!')),
                );
          }
        },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _FirstNameInput(),
          _LastNameInput(),
          _BirthDataInput(),
          const SizedBox(height: 16.0,),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _CancelButton()),
              const SizedBox(width: 8.0,),
              Expanded(child: _SubmitButton())
            ],
          )
        ],
      ),
      );
  }
}

class _FirstNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        buildWhen: (previous, current) => previous.firstName != current.firstName,
        builder: (context, state) {
          return TextField(
            key: const Key('KindPersonalInfoForm_firstNameInput_textField'),
            onChanged: (firstName) =>
            context.read<KindPersonalInfoBloc>()
                .add(FirstNameChanged(firstName)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text('Vorname des Schwimmschülers',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                ),
              ),
              errorText: state.firstName.invalid
                  ? state.firstName.error?.message
                  : null,
            ),
          );
        }
       );
  }
}

class _LastNameInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        buildWhen: (previous, current) => previous.lastName != current.lastName,
        builder: (context, state) {
          return TextField(
            key: const Key('KindPersonalInfoForm_lastNameInput_textField'),
            onChanged: (lastName) =>
                context.read<KindPersonalInfoBloc>()
                    .add(LastNameChanged(lastName)),
            decoration: InputDecoration(
              label: const FittedBox(
                fit: BoxFit.fitWidth,
                child: Row(
                  children: [
                    Text('Nachname des Schwimmschülers',
                      style: TextStyle(
                          fontWeight: FontWeight.bold),),
                    Padding(
                      padding: EdgeInsets.all(3.0),
                    ),
                    Text('*',
                        style: TextStyle(
                            color: Colors.red,
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ],
                ),
              ),
              errorText: state.lastName.invalid
                  ? state.lastName.error?.message
                  : null,
            ),
          );
        }
    );
  }
}

class _BirthDataInput extends StatelessWidget {
  // Define _textField as an instance variable.
  final TextEditingController _textField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
      buildWhen: (previous, current) =>
      previous.birthDay != current.birthDay,
      builder: (context, state) {
        return TextField(
          key: const Key('personalInfoForm_birthDayInput_textField'),
          // onChanged: (birthday) => context
          //     .read<PersonalInfoBloc>()
          //     .add(BirthdayChanged(birthday)),
          controller: _textField,
          readOnly: true,
          onTap: () async {
            DatePicker.showDatePicker(context,
                showTitleActions: true,
                currentTime: DateTime.now(),
                locale: LocaleType.de,
                maxTime: DateTime(2022, 1, 1),
                onConfirm: (date) {
                  // Set the date in the text field.
                  // (Note: We need to use DateFormat to format the date.)
                  var formattedDate = DateFormat('dd.MM.yyyy').format(date);
                  // Set the text of the text field.
                  _textField.text = formattedDate;
                  context
                      .read<KindPersonalInfoBloc>()
                      .add(BirthDayChanged(formattedDate));
                });
          },
          keyboardType: TextInputType.datetime,
          decoration: InputDecoration(
            label: const FittedBox(
              fit: BoxFit.fitWidth,
              child: Row(
                children: [
                  Text('Geburtstag des Kindes',
                    style: TextStyle(
                        fontWeight: FontWeight.bold),),
                  Padding(
                    padding: EdgeInsets.all(3.0),
                  ),
                  Text('*',
                      style: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold
                      )
                  ),
                ],
              ),
            ),
            errorText: state.birthDay.invalid
                ? state.birthDay.error?.message
                : null,
          ),
        );
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KindPersonalInfoBloc, KindPersonalInfoState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status.isSubmissionSuccess) {
          context.read<SignupCubit>().stepContinued();
        }
      },
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
          key: const Key('kindPersonalInfoForm_submitButton_elevatedButton'),
          style: ElevatedButton.styleFrom(elevation: 0),
          onPressed: state.status.isValidated
              ? () =>
              context.read<KindPersonalInfoBloc>().add(FormSubmitted())
              : null,
          child: const Text('Weiter'),
        );
      },
    );
  }
}

class _CancelButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KindPersonalInfoBloc, KindPersonalInfoState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const SizedBox.shrink()
              : TextButton(
            key: const Key('kindPersonalInfoForm_cancelButton_elevatedButton'),
            onPressed: () => context.read<SignupCubit>().stepCancelled(),
            child: const Text('Abrechen'),
          );
        }
      );
  }
}