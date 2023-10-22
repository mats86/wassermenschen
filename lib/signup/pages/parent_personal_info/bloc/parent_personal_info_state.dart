part of 'parent_personal_info_bloc.dart';

class ParentPersonalInfoState extends Equatable {
  const ParentPersonalInfoState({this.titleList = ''});

  final String titleList;

  ParentPersonalInfoState copyWith({
    String? titleList,
  }) {
    return ParentPersonalInfoState(titleList: titleList ?? this.titleList);
  }

  @override
  List<Object?> get props => [titleList];
}
