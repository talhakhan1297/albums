part of 'cache_client.dart';

// ignore_for_file: strict_raw_type, inference_failure_on_function_invocation
/// A simple cache client that uses hive.
class HiveCacheClient implements CacheClient {
  ///
  HiveCacheClient({HiveInterface? hive}) : _cache = (hive ?? Hive).box('cache');

  final Box _cache;

  /// Initializes Hive Cache client
  static Future<void> initializeCache({HiveInterface? hive}) async {
    final hiveObject = hive ?? Hive;
    final appDocDir = await getApplicationDocumentsDirectory();
    final appDocPath = appDocDir.path;
    hiveObject.init('$appDocPath/cache');
    await hiveObject.openBox('cache');
  }

  @override
  T? read<T extends Object>({required String key}) {
    final value = _cache.get(key);
    if (value is T) return value;
    return null;
  }

  @override
  void write<T extends Object>({required String key, required T value}) {
    _cache.put(key, value);
  }

  @override
  Future<void> clear() async {
    await _cache.clear();
  }

  @override
  Future<void> close() async {
    await _cache.close();
  }
}
