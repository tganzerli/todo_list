/// Represents the parameters required for caching operations.
///
/// This class is used to store a key-value pair that can be cached.
class CacheParams {
  /// The unique key identifying the cached data.
  final String key;

  /// The value associated with the key in the cache.
  final dynamic value;

  /// Creates a `CacheParams` instance with the given key and value.
  const CacheParams({
    required this.key,
    required this.value,
  });
}
