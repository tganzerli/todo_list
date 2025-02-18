import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/validator/title_validator.dart';

class TitleTextFieldViewmodel extends ViewModel<UnitViewState> {
  late final Command1<Unit, String> validator;

  TitleTextFieldViewmodel() : super(UnitViewState()) {
    validator = Command1(_validator);
  }

  AsyncOutput<Unit> _validator(String text) async {
    return TitleValidator.validate(text);
  }
}
