import 'package:flutter/services.dart';
import 'package:yaml/yaml.dart';

class AppConfig {
  final String _commonAppConfigPath = 'assets/common/config/appConfig.yaml';
  final String _configPath;
  Map _configMap = {};
  bool _initialized = false;

  AppConfig(this._configPath);

  void printAllProperties() {
    _configMap.entries.forEach((property) {
      print(property);
    });
  }

  dynamic getProperty(String propertyName) {
    if (!_configMap.containsKey(propertyName)) {
      throw new Exception("Could not found propertyName: $propertyName");
    }
    return _configMap[propertyName];
  }

  Future<AppConfig> init() async {
    if (_initialized != true) {
      var commonAppConfig = await _readCommonAppConfig();
      var appConfig = await _readAppConfig();
      var allConfigFileProperties = {}
        ..addAll(commonAppConfig)
        ..addAll(appConfig);
      var allEnvProperties = _readEnvProperties(allConfigFileProperties.keys);
      _configMap
        ..addAll(allConfigFileProperties)
        ..addAll(allEnvProperties);
      _initialized = true;
    }
    return this;
  }

  Map _readEnvProperties(Iterable<dynamic> propertyNames) {
    var allEnvProperties = {};
    propertyNames.forEach((propertyName) {
      var propEnvValue = _readEnvironmentVar(propertyName);
      if (propEnvValue != null) {
        allEnvProperties.putIfAbsent(propertyName, () => propEnvValue);
      }
    });
    return allEnvProperties;
  }

  Future<Map<dynamic, dynamic>> _readCommonAppConfig() async {
    var yamlString = rootBundle.loadString(_commonAppConfigPath);
    return yamlString.then((yaml) => loadYaml(yaml) as Map);
  }

  Future<Map> _readAppConfig() async {
    var yamlString = rootBundle.loadString(_configPath);
    return yamlString.then((yaml) => loadYaml(yaml) as Map);
  }

  String? _readEnvironmentVar(String varName) {
    return bool.hasEnvironment(varName) ? String.fromEnvironment(varName) : null;
  }
}
