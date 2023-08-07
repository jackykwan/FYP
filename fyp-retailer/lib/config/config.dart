import 'base_config.dart';
import 'dev_config.dart';

final _dev = DevConfig();

class _Config implements BaseConfig {
  final BaseConfig _config = _dev;

  @override
  String get apiHost => _config.apiHost;
}

final envConfig = _Config();
