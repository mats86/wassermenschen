part of 'kind_personal_info_bloc.dart';

class KindPersonalInfoState extends Equatable {
  const KindPersonalInfoState({
    this.firstName = const FirstName.pure(),
    this.lastName = const LastName.pure(),
    this.birthDay = const BirthDay.pure(),
    this.status = FormzStatus.pure,
  });

  final FirstName firstName;
  final LastName lastName;
  final BirthDay birthDay;
  final FormzStatus status;

  KindPersonalInfoState copyWith({
    FirstName? firstName,
    LastName? lastName,
    BirthDay? birthDay,
    FormzStatus? status,
  }) {
    return KindPersonalInfoState(
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      birthDay: birthDay ?? this.birthDay,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [firstName, lastName, birthDay, status];
}