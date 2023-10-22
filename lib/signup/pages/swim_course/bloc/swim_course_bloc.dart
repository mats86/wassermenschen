import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:http/http.dart' as http;

import '../models/models.dart';

import '../../../../logic/models/AppConfig.dart';
import '../../../../logic/models/models.dart';

part 'swim_course_event.dart';
part 'swim_course_service.dart';
part 'swim_course_state.dart';

class SwimCourseBloc extends Bloc<SwimCourseEvent, SwimCourseState> {
  final SwimCourseService _service;

  SwimCourseBloc(this._service) : super(const SwimCourseState()) {
    on<SwimSeasonChanged>(_onSwimSeasonChanged);
    on<SwimCourseChanged>(_onSwimCourseChanged);
    on<LoadSwimSeasonOptions>(_onLoadSwimSeasonOptions);
    on<LoadSwimCourseOptions>(_onLoadSwimCourseOptions);
    on<FormSubmitted>(_onFormSubmitted);
  }

  void _onSwimSeasonChanged(SwimSeasonChanged event,
      Emitter<SwimCourseState> emit) {
    final swimSeason = SwimSeasonModels.dirty(event.swimSeason);
    emit(state.copyWith(
        swimSeason: swimSeason,
        status: Formz.validate([swimSeason, state.swimCourse])));
  }

  void _onSwimCourseChanged(SwimCourseChanged event,
      Emitter<SwimCourseState> emit) {
    final swimCourse = SwimCourseModels.dirty(event.swimCourse);
    emit(state.copyWith(
        swimCourse: swimCourse,
        status: Formz.validate([state.swimSeason, swimCourse])));
  }

  void _onLoadSwimSeasonOptions(LoadSwimSeasonOptions event,
      Emitter<SwimCourseState> emit) async {
    emit(state.copyWith(loadingSeasonStatus: FormzStatus.submissionInProgress));
    try {
      final swimSeason = await _service._fetchSwimSeason();
      emit(state.copyWith(
          swimSeasons: swimSeason,
          swimSeason: SwimSeasonModels.dirty(swimSeason[0]),
          loadingSeasonStatus: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(loadingSeasonStatus: FormzStatus.submissionFailure));
    }
  }

  void _onLoadSwimCourseOptions(LoadSwimCourseOptions event,
      Emitter<SwimCourseState> emit) async {
    emit(state.copyWith(loadingCourseStatus: FormzStatus.submissionInProgress));
    try {
      final swimCourses = await _service._fetchSwimCourses();
      emit(state.copyWith(
          swimCourseOptions: swimCourses,
          loadingCourseStatus: FormzStatus.submissionSuccess));
    } catch (_) {
      emit(state.copyWith(loadingCourseStatus: FormzStatus.submissionFailure));
    }
  }

  void _onFormSubmitted(FormSubmitted event, Emitter<SwimCourseState> emit) {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));
      // Implement the actual form submission logic here
      // For now, just simulating a successful form submission
      Future.delayed(const Duration(seconds: 2), () {
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      });
    }
  }
}
