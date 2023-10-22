import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'parent_personal_info_event.dart';
part 'parent_personal_info_state.dart';

class ParentPersonalInfoBloc extends Bloc<ParentPersonalInfoEvent, ParentPersonalInfoState> {
  ParentPersonalInfoBloc(super.initialState);

}