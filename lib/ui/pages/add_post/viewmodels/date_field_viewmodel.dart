import 'package:todo_list/core/core.dart';
import 'package:todo_list/domain/validator/date_validator.dart';

class DateFieldViewmodel extends ViewModel<UnitViewState> {
  late final Command1<Unit, DateTime> validator;

  DateFieldViewmodel() : super(UnitViewState()) {
    validator = Command1(_validator);
  }

  AsyncOutput<Unit> _validator(DateTime date) async {
    return DateValidator.validate(date);
  }
}
