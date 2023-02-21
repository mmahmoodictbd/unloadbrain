import '../app_specific_context_factory.dart';
import 'app_router.dart';
import 'app_specific_context.dart';

class AppContext {
  final Map<String, dynamic> _userProvidedVariables;
  static final Map<String, dynamic> _internalVariables = {};
  static AppSpecificContext? _appSpecificContext;

  static late AppContext _instance;

  static AppContext get instance {
    return _instance;
  }

  factory AppContext({Map<String, dynamic> userProvidedVariables = const {}}) {
    _instance = AppContext._internal(userProvidedVariables);
    return _instance;
  }

  AppContext._internal(this._userProvidedVariables);

  void init() {
    _determineAppName();
    _loadAppSpecificContext();;
  }

  void _determineAppName() {
    const appName = String.fromEnvironment('appName', defaultValue: 'NO_APP_SELECTED');
    if (appName == 'NO_APP_SELECTED') {
      throw new Exception("No 'appName' selected. Add --dart-define=appName=<APP_NAME>");
    }
    _internalVariables.putIfAbsent("appName", () => appName);
  }

  void _loadAppSpecificContext() {
    _appSpecificContext = AppSpecificContextFactory.getAppSpecificContext(getAppName());
  }

  String getAppName() => _internalVariables["appName"];

  Map<String, dynamic> getValues() => _instance._userProvidedVariables;

  dynamic getValue(String key) => _instance._userProvidedVariables[key];

  AppRouter getAppRouter() {
    return _appSpecificContext!.getAppRouter();
  }
}
