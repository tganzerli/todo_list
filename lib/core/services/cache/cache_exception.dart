import 'package:todo_list/core/core.dart';

/// Represents an exception that occurs when dealing with cache operations.
///
/// This exception extends `BaseException` to provide a more specific
/// error message related to caching failures.
class CacheException extends BaseException {
  /// Creates a `CacheException` with a required message and optional stack trace.
  const CacheException({
    required super.message,
    super.stackTracing,
  });
}
