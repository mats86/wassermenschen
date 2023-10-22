part of 'parent_personal_info_bloc.dart';

abstract class ParentPersonalInfoEvent extends Equatable {
  const ParentPersonalInfoEvent();

  @override
  List<Object> get props => [];
}

class TitleChanged extends ParentPersonalInfoEvent {
  final String title;
  const TitleChanged(this.title);

  @override
  List<Object> get props => [title];
}