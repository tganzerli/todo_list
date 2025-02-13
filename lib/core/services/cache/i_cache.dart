import 'cache_params.dart';

/// Defines an interface for a cache management system.
///
/// This interface provides methods for setting, retrieving,
/// and removing cached data.
abstract interface class Cache {
  /// Saves data in the cache.
  ///
  /// Returns `true` if the operation is successful, otherwise `false`.
  Future<bool> setData({required CacheParams params});

  /// Retrieves data from the cache using a unique key.
  ///
  /// Returns the cached value if found, otherwise `null`.
  Future<dynamic> getData(String key);

  /// Removes a specific cached item by key.
  ///
  /// Returns `true` if the item was successfully removed, otherwise `false`.
  Future<bool> removeData(String key);

  /// Clears all stored cache data.
  ///
  /// Returns `true` if the operation is successful, otherwise `false`.
  Future<bool> clearAll();
}
