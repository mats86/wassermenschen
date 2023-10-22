import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:formz/formz.dart';

import '../../../cubit/signup_cubit.dart';
import '../bloc/swim_course_bloc.dart';

class SwimCourseForm extends StatefulWidget {
  const SwimCourseForm({Key? key}) : super(key: key);

  @override
  State<SwimCourseForm> createState() => _SwimCourseForm();
}

class _SwimCourseForm extends State<SwimCourseForm> {
  @override
  void initState() {
    super.initState();
    context.read<SwimCourseBloc>().add(LoadSwimSeasonOptions());
    context.read<SwimCourseBloc>().add(LoadSwimCourseOptions());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SwimCourseBloc, SwimCourseState>(
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
          _SwimCourseSeason(),
          const SizedBox(
            height: 32,
          ),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "Dem Alter entsprechende Kurse",
            ),
          ),
          _SwimCourseRadioButton(),
          const Divider(),
          const Align(
            alignment: Alignment.centerLeft,
            child: Text(
              "¹ Eine Kursübersicht über all unsere von uns angebotenen Kurse.",
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(child: _CancelButton()),
              const SizedBox(
                width: 8.0,
              ),
              Expanded(child: _SubmitButton())
            ],
          )
        ],
      ),
    );
  }
}

class _SwimCourseSeason extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimCourseBloc, SwimCourseState>(
      builder: (context, state) {
        return InputDecorator(
          decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
            labelText: 'Für welche Sommer-Saison möchtest du den Kurs buchen?',
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
          ),
          child: DropdownButtonHideUnderline(
            child: !state.loadingSeasonStatus.isSubmissionSuccess
                ? const SpinKitWaveSpinner(
                    color: Colors.lightBlueAccent,
                    size: 50.0,
                  )
                : DropdownButton<String>(
                    isExpanded: true,
                    value: state.swimSeason
                        .value, // Hier sollte der ausgewählte Wert sein
                    items: state.swimSeasons.map((String season) {
                      return DropdownMenuItem<String>(
                        value: season,
                        child: Text(season),
                      );
                    }).toList(),
                    onChanged: (value) {
                      // Dies wird aufgerufen, wenn der Benutzer ein Element auswählt.
                      BlocProvider.of<SwimCourseBloc>(context)
                          .add(SwimSeasonChanged(value!));
                    },
                  ),
          ),
        );
      },
    );
  }
}

class _SwimCourseRadioButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SwimCourseBloc, SwimCourseState>(
        builder: (context, state) {
      return !state.loadingCourseStatus.isSubmissionSuccess
          ? const SpinKitWaveSpinner(
              color: Colors.lightBlueAccent,
              size: 50.0,
            )
          : ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              itemCount: state.swimCourseOptions.length,
              itemBuilder: (context, index) {
                return SizedBox(
                  // height: 50, // Sie können die Höhe nach Bedarf festlegen oder entfernen
                  child: Visibility(
                    visible:
                        true, //state.swimCourseOptions[index].isCourseVisible,
                    child: Row(
                      children: [
                        Radio(
                          groupValue: state.swimCourse
                              .value, //state.swimCourseOptions.first.courseName,
                          value: state.swimCourseOptions[index].courseName,
                          onChanged: (val) {
                            //state.swimCourseOptions = val.toString()
                            // Hier sollte die Auswahl aktualisiert werden
                            BlocProvider.of<SwimCourseBloc>(context)
                                .add(SwimCourseChanged(val.toString()));
                          },
                        ),
                        Flexible(
                          child: Wrap(
                            children: [
                              Text(
                                '${state.swimCourseOptions[index].courseName} '
                                '${state.swimCourseOptions[index].coursePrice} €',
                                overflow: TextOverflow
                                    .visible, // Bei Bedarf können Sie Text Beschneidung hinzufügen
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          // onPressed: () => showCourseDescription(context,
                          // //     index),
                          icon: const Icon(
                            Icons.info_rounded,
                            color: Colors.blue,
                            size: 20,
                          ),
                          onPressed: () {},
                        )
                      ],
                    ),
                  ),
                );
              },
            );
    });
  }
}

class _SubmitButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SwimCourseBloc, SwimCourseState>(
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
                key: const Key('swimCourseForm_submitButton_elevatedButton'),
                style: ElevatedButton.styleFrom(elevation: 0),
                onPressed: state.status.isValidated
                    ? () => context.read<SwimCourseBloc>().add(FormSubmitted())
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
    return BlocBuilder<SwimCourseBloc, SwimCourseState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          return state.status.isSubmissionInProgress
              ? const SizedBox.shrink()
              : TextButton(
                  key: const Key('swimCourseForm_cancelButton_elevatedButton'),
                  onPressed: () => context.read<SignupCubit>().stepCancelled(),
                  child: const Text('Zurück'),
                );
        });
  }
}
