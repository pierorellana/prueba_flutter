
import 'package:prueba_flutter/env/config/config_base.dart';

class ProdEnv extends BaseConfig{
  @override
  String get appName => 'Prueba App';

  @override
  String get serviceUrl => 'url';
}