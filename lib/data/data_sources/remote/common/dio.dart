import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:url_shortener/env.dart';

@module
abstract class DioModule {
  @Singleton(dispose: dispose)
  Dio get instance => Dio(BaseOptions(baseUrl: Env.baseUrl));
}

void dispose(Dio instance) {
  instance.close();
}
