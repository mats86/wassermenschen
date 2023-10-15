part of 'signup_cubit.dart';

class SignupState extends Equatable {
  const SignupState({
    this.activeStepperIndex = 0,
  });

  final int activeStepperIndex;

  SignupState copyWith({int? activeStepperIndex}) {
    return SignupState(
      activeStepperIndex: activeStepperIndex ?? this.activeStepperIndex,
    );
  }

  @override
  List<Object> get props => [activeStepperIndex];
}