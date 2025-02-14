import 'package:todo_list/core/core.dart';

/// This class serves as a blueprint for parameter objects that require validation.
/// Implementing classes must override the `validate()` method to provide custom validation logic.
///
/// Example usage:
/// ```dart
/// class MyParameters extends Parameters {
///   @override
///   Output<Parameters> validate() {
///     // Perform validation logic
///     return Output(this, true, "Validation successful");
///   }
/// }
/// ```
abstract class Parameters {
  /// Validates the current parameter set.
  ///
  /// This method should be implemented in subclasses to define the validation logic
  /// for specific parameter configurations.
  ///
  /// Returns an `Output<Parameters>` object containing the validation result.
  Output<Parameters> validate();
}
