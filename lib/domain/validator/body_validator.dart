import 'package:todo_list/core/core.dart';

class BodyValidator {
  static Output<Unit> validate(String? body) {
    if (body != null && body.isEmpty) {
      return failure(ValidationException(message: 'Post sem Texto'));
    }
    if (body != null && body.length > 500) {
      return failure(ValidationException(message: 'Texto muito grande'));
    }
    return success(unit);
  }
}
