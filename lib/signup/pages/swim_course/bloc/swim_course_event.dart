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

class FormSubmitted extends SwimCourseEvent {}