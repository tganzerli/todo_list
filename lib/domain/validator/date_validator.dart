import 'package:todo_list/core/core.dart';

class DateValidator {
  static Output<Unit> validate(DateTime? date) {
    if (date != null && date.difference(DateTime.now()).inDays.isNegative) {
      return failure(ValidationException(
          message: 'Só são permitidas datas a partir de hoje.'));
    }

    return success(unit);
  }
}
