import 'package:envied/envied.dart';

part 'env.g.dart';

@Envied()
class Env {
  const Env._();

  @EnviedField(varName: 'BASE_URL')
  static const String baseUrl = _Env.baseUrl;
}
