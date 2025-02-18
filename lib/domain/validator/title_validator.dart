import 'package:todo_list/core/core.dart';

class TitleValidator {
  static Output<Unit> validate(String? title) {
    if (title != null && title.isEmpty) {
      return failure(ValidationException(message: 'Post sem titulo'));
    }
    if (title != null && title.length > 100) {
      return failure(ValidationException(message: 'Titulo muito grande'));
    }
    return success(unit);
  }
}
