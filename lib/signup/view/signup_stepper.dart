import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:im_stepper/stepper.dart';
import 'package:wassermenschen/signup/pages/swim_pool/view/swim_pool_page.dart';

import '../cubit/signup_cubit.dart';
import '../pages/kind_personal_info/kind_personal_info.dart';
import '../pages/swim_course/swim_course.dart';

class SignupStepper extends StatelessWidget {
  const SignupStepper({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            children: [
              NumberStepper(
                enableNextPreviousButtons: false,
                numbers: const [
                  1,
                  2,
                  3,
                  4,
                  5,
                ],
                activeStep: state.activeStepperIndex,
                onStepReached: (index) {
                  context.read<SignupCubit>().stepTapped(index);
                },
              ),
              header(state.activeStepperIndex),
              body(state.activeStepperIndex)
            ],
          ),
        );
      },
    );
  }

  /// Returns the header wrapping the header text.
  Widget header(int activeStepperIndex) {
    return Container(
      decoration: BoxDecoration(
        // color: Colors.orange,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          headerText(activeStepperIndex),
          style: const TextStyle(
            // color: Colors.black,
            fontSize: 20,
          ),
        ),
      ),
    );
  }

  // Returns the header text based on the activeStep.
  String headerText(int activeStepperIndex) {
    switch (activeStepperIndex) {
      case 0:
        return 'Persönliche Informationen';

      case 1:
        return 'Table of Contents';

      case 2:
        return 'About the Author';

      case 3:
        return 'Publisher Information';

      case 4:
        return 'Reviews';

      case 5:
        return 'Chapters #1';

      default:
        return 'Introduction';
    }
  }

  /// Returns the body.
  Widget body(int activeStepperIndex) {
    switch (activeStepperIndex) {
      case 0:
        return const KindPersonalInfoPage();

      case 1:
        return const SwimCoursePage();

      case 2:
        return const SwimPoolPage();

      default:
        return Container();
    }
  }
}
