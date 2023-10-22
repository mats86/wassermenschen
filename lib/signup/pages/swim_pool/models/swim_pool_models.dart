import 'package:formz/formz.dart';
import 'package:wassermenschen/logic/models/models.dart';

enum SwimPoolModelsValidationError { required, invalid }

extension Explanation on SwimPoolModelsValidationError {
  String get message {
    switch (this) {
      case SwimPoolModelsValidationError.required:
        return 'Bitte wählen Sie mindestens eine Option aus';
      case SwimPoolModelsValidationError.invalid:
        return 'Die eingegebene Option ist ungültig';
      default:
        return '';
    }
  }
}

class SwimPoolModels extends FormzInput<List<SwimPools>, SwimPoolModelsValidationError> {
  const SwimPoolModels.pure() : super.pure(const []);
  const SwimPoolModels.dirty([List<SwimPools> value = const []]) : super.dirty(value);

  @override
  SwimPoolModelsValidationError? validator(List<SwimPools> value) {
    if (value.isEmpty || value.every((pool) => !pool.isSelected)) {
      return SwimPoolModelsValidationError.required;
    }
    return null;
  }
}
