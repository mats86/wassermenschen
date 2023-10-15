import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

import '../models/birth_day.dart';
import '../models/first_name.dart';
import '../models/last_name.dart';

part 'kind_personal_info_event.dart';
part 'kind_personal_info_state.dart';

class KindPersonalInfoBloc extends
                          Bloc<KindPersonalInfoEvent, KindPersonalInfoState> {
  final UserRepository userRepository;

  KindPersonalInfoBloc({required this.userRepository})
      : super(const KindPersonalInfoState()) {
    on<FirstNameChanged>(_onFirstNameChanged);
    on<LastNameChanged>(_onLastNameChanged);
    on<BirthDayChanged>(_onBirthDayChanged);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onFirstNameChanged(
      FirstNameChanged event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final firstName = FirstName.dirty(event.firstName);
    emit(state.copyWith(
      firstName: firstName,
      status: Formz.validate([firstName, state.lastName, state.birthDay]),
    ));
  }

  void _onLastNameChanged(
      LastNameChanged event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final lastName = LastName.dirty(event.lastName);
    emit(state.copyWith(
      lastName: lastName,
      status: Formz.validate([state.firstName, lastName, state.birthDay]),
    ));
  }

  void _onBirthDayChanged(
      BirthDayChanged event,
      Emitter<KindPersonalInfoState> emit,
      ) {
    final birthDay = BirthDay.dirty(event.birthDay);
    emit(state.copyWith(
      birthDay: birthDay,
      status: Formz.validate([state.firstName, state.lastName, birthDay]),
    ));
  }

  void _onFormSubmitted(
      FormSubmitted event,
      Emitter<KindPersonalInfoState> emit,
      ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      try {
        await userRepository.updatePersonalInfo(
            firstName: state.firstName.value,
            email: state.lastName.value,
            phoneNumber: state.lastName.value,
        );
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }
}