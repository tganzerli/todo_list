import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/core/core.dart';

void main() {
  group('DefaultException Tests', () {
    test('DefaultException should extend BaseException', () {
      const defaultException = DefaultException(
        message: 'Default error',
        stackTracing: 'Default stack trace',
      );

      expect(defaultException, isA<BaseException>());
      expect(defaultException.message, 'Default error');
      expect(defaultException.stackTracing, 'Default stack trace');
    });

    test('DefaultException should work with only message', () {
      const defaultException = DefaultException(
        message: 'Only message provided',
      );

      expect(defaultException.message, 'Only message provided');
      expect(defaultException.stackTracing, isNull);
    });
  });

  group('ValidationException Tests', () {
    test('ValidationException should extend BaseException', () {
      const exception = ValidationException(
        message: 'Validation error',
        stackTracing: 'Validation stack trace',
      );

      expect(exception, isA<BaseException>());
      expect(exception.message, 'Validation error');
      expect(exception.stackTracing, 'Validation stack trace');
    });

    test('ValidationException should work with only message', () {
      const exception = ValidationException(
        message: 'Only message provided',
      );

      expect(exception.message, 'Only message provided');
      expect(exception.stackTracing, isNull);
    });
  });

  group('FormatedException Tests', () {
    test('FormatedException should extend BaseException', () {
      const exception = FormatedException(
        message: 'Formated error',
        stackTracing: 'Formated stack trace',
      );

      expect(exception, isA<BaseException>());
      expect(exception.message, 'Formated error');
      expect(exception.stackTracing, 'Formated stack trace');
    });

    test('FormatedException should work with only message', () {
      const exception = FormatedException(
        message: 'Only message provided',
      );

      expect(exception.message, 'Only message provided');
      expect(exception.stackTracing, isNull);
    });
  });
}
