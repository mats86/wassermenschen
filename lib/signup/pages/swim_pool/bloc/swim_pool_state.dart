part of 'swim_pool_bloc.dart';

class SwimPoolState extends Equatable {
  final List<SwimPools> swimPools;
  final FormzStatus loadingStatus;
  final FormzStatus toggleStatus;
  final SwimPoolModels swimPoolModels;

  const SwimPoolState({
    this.swimPools = const [],
    this.loadingStatus = FormzStatus.pure,
    this.toggleStatus = FormzStatus.pure,
    this.swimPoolModels = const SwimPoolModels.pure(),
  });

  SwimPoolState copyWith({
    List<SwimPools>? swimPools,
    FormzStatus? loadingStatus,
    FormzStatus? toggleStatus,
    SwimPoolModels? swimPoolModels,
  }) {
    return SwimPoolState(
      swimPools: swimPools ?? this.swimPools,
      loadingStatus: loadingStatus ?? this.loadingStatus,
      toggleStatus: toggleStatus ?? this.toggleStatus,
      swimPoolModels: swimPoolModels ?? this.swimPoolModels,
    );
  }

  @override
  List<Object?> get props => [swimPools, loadingStatus, toggleStatus, swimPoolModels];
}
