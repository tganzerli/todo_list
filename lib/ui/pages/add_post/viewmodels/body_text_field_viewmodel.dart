import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/validator/body_validator.dart';

class BodyTextFieldViewmodel extends ViewModel<UnitViewState> {
  late final Command1<Unit, String> validator;

  BodyTextFieldViewmodel() : super(UnitViewState()) {
    validator = Command1(_validator);
  }

  AsyncOutput<Unit> _validator(String text) async {
    return BodyValidator.validate(text);
  }
}
