import 'package:auto_injector/auto_injector.dart';
import 'package:dio/dio.dart';
import 'package:todo_list/core/config/injector.dart';

import 'core.dart';
import 'services/cache/shared_preferences/shared_preferences.dart';
import 'services/client/dio/dio_impl.dart';

export 'contracts/contracts.dart';
export 'errors/errors.dart';
export 'output/output.dart';
export 'services/services.dart';

void coreInjector() {
  injector.addSingleton<Cache>(SharedPreferencesImpl.new);
  injector.add<Dio>(DioFactory.dio);
  injector.addSingleton<RestClient>(RestClientDioImpl.new);
}
