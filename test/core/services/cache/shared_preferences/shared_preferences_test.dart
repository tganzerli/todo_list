import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_list/core/core.dart';
import 'package:todo_list/core/services/cache/shared_preferences/shared_preferences.dart';

void main() {
  late SharedPreferencesImpl cache;

  setUp(() {
    cache = SharedPreferencesImpl();
    SharedPreferences.setMockInitialValues({});
  });

  group('SharedPreferencesImpl - setData & getData', () {
    test('should store and retrieve a String', () async {
      const params = CacheParams(key: 'stringKey', value: 'testValue');

      await cache.setData(params: params);
      final result = await cache.getData('stringKey');

      expect(result, 'testValue');
    });

    test('should store and retrieve a Boolean', () async {
      const params = CacheParams(key: 'boolKey', value: true);

      await cache.setData(params: params);
      final result = await cache.getData('boolKey');

      expect(result, true);
    });

    test('should store and retrieve a List<String>', () async {
      const params = CacheParams(key: 'listKey', value: ['item1', 'item2']);

      await cache.setData(params: params);
      final result = await cache.getData('listKey');

      expect(result, ['item1', 'item2']);
    });

    test('should store and retrieve a Map<String, dynamic>', () async {
      const params = CacheParams(key: 'mapKey', value: {'key1': 'value1'});

      await cache.setData(params: params);
      final result = await cache.getData('mapKey');

      expect(result, {'key1': 'value1'});
    });

    test('should throw CacheException when retrieving a non-existing key',
        () async {
      expect(() => cache.getData('invalidKey'), throwsA(isA<CacheException>()));
    });
  });

  group('SharedPreferencesImpl - removeData', () {
    test('should remove data and throw exception when retrieving removed key',
        () async {
      const params = CacheParams(key: 'removeKey', value: 'toBeRemoved');

      await cache.setData(params: params);
      expect(await cache.getData('removeKey'), 'toBeRemoved');

      await cache.removeData('removeKey');
      expect(() => cache.getData('removeKey'), throwsA(isA<CacheException>()));
    });
  });

  group('SharedPreferencesImpl - clearAll', () {
    test('should clear all data and ensure no data remains', () async {
      await cache.setData(params: CacheParams(key: 'key1', value: 'value1'));
      await cache.setData(params: CacheParams(key: 'key2', value: 123));

      await cache.clearAll();

      expect(() => cache.getData('key1'), throwsA(isA<CacheException>()));
      expect(() => cache.getData('key2'), throwsA(isA<CacheException>()));
    });
  });
}
