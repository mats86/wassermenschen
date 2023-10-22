part of 'swim_course_bloc.dart';

class SwimCourseState extends Equatable {
  const SwimCourseState({
    this.swimSeasons = const [],
    this.swimSeason = const SwimSeasonModels.pure(),
    this.swimCourseOptions = const [],
    this.swimCourse = const SwimCourseModels.pure(),
    this.loadingSeasonStatus = FormzStatus.pure,
    this.loadingCourseStatus = FormzStatus.pure,
    this.status = FormzStatus.pure,
  });

  final List<String> swimSeasons;
  final SwimSeasonModels swimSeason;
  final List<SwimCourse> swimCourseOptions;
  final SwimCourseModels swimCourse;
  final FormzStatus loadingSeasonStatus;
  final FormzStatus loadingCourseStatus;
  final FormzStatus status;

  SwimCourseState copyWith({
    List<String>? swimSeasons,
    SwimSeasonModels? swimSeason,
    List<SwimCourse>? swimCourseOptions,
    SwimCourseModels? swimCourse,
    FormzStatus? loadingSeasonStatus,
    FormzStatus? loadingCourseStatus,
    FormzStatus? status,
  }) {
    return SwimCourseState(
      swimSeasons: swimSeasons ?? this.swimSeasons,
      swimSeason: swimSeason ?? this.swimSeason,
      swimCourseOptions: swimCourseOptions ?? this.swimCourseOptions,
      swimCourse: swimCourse ?? this.swimCourse,
      loadingSeasonStatus: loadingSeasonStatus ?? this.loadingSeasonStatus,
      loadingCourseStatus: loadingCourseStatus ?? this.loadingCourseStatus,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [
        swimSeasons,
        swimSeason,
        swimCourseOptions,
        swimCourse,
        loadingSeasonStatus,
        loadingCourseStatus,
        status
      ];
}
