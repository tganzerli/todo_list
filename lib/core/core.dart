import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';

import 'core.dart';
import 'services/cache/shared_preferences/shared_preferences.dart';
import 'services/client/dio/dio_impl.dart';

export 'contracts/contracts.dart';
export 'errors/errors.dart';
export 'output/output.dart';
export 'services/services.dart';

final coreInjector = AutoInjector(
  tag: 'core',
  on: (injector) {
    injector.addSingleton<Cache>(SharedPreferencesImpl.new);
    injector.add<Dio>(DioFactory.dio);
    injector.addSingleton<RestClient>(RestClientDioImpl.new);
  },
);
