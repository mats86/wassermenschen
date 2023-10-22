part of 'swim_course_bloc.dart';

abstract class SwimCourseEvent extends Equatable {
  const SwimCourseEvent();

  @override
  List<Object> get props => [];
}

class SwimCourseChanged extends SwimCourseEvent {
  final String swimCourse;
  const SwimCourseChanged(this.swimCourse);

  @override
  List<Object> get props => [swimCourse];
}

class SwimSeasonChanged extends SwimCourseEvent {
  final String swimSeason;
  const SwimSeasonChanged(this.swimSeason);

  @override
  List<Object> get props => [swimSeason];
}

class LoadSwimSeasonOptions extends SwimCourseEvent {}

class LoadSwimCourseOptions extends SwimCourseEvent {}

class FormSubmitted extends SwimCourseEvent {}
