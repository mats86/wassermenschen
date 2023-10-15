import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.stepperLength) : super(const SignupState());
  final int stepperLength;
  
  void stepTapped(int tappedIndex) =>
      emit(SignupState(activeStepperIndex: tappedIndex));

  void stepContinued() {
    if (state.activeStepperIndex < stepperLength - 1) {
      emit(SignupState(activeStepperIndex: state.activeStepperIndex + 1));
    } else {
      emit(SignupState(activeStepperIndex: state.activeStepperIndex));
    }
  }

  void stepCancelled() {
    if (state.activeStepperIndex > 0) {
      emit(SignupState(activeStepperIndex: state.activeStepperIndex - 1));
    } else {
      emit(SignupState(activeStepperIndex: state.activeStepperIndex));
    }
  }
}