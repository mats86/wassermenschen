part of'swim_course_bloc.dart';

class SwimCourseState extends Equatable {
  const SwimCourseState({
    this.swimCourseOptions = const [],
    this.swimCourse = '',// Default value for swimCourse
    this.status = FormzStatus.pure,
  });
  final List<SwimCourse> swimCourseOptions;
  final String swimCourse;
  final FormzStatus status;

  SwimCourseState copyWith({
    List<SwimCourse>? swimCourseOptions,
    String? swimCourse,
    FormzStatus? status,
  }) {
    return SwimCourseState(
      swimCourseOptions: swimCourseOptions ?? this.swimCourseOptions,
        swimCourse: swimCourse ?? this.swimCourse,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [swimCourseOptions, swimCourse, status]; // Dynamische Radio-Optionen
}