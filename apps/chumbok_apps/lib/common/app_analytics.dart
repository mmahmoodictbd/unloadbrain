import 'package:firebase_analytics/firebase_analytics.dart';

class AppAnalytics {
  final String _appName;
  final FirebaseAnalytics _firebaseAnalytics;

  AppAnalytics(this._appName, this._firebaseAnalytics);

  void logAppOpen() => _firebaseAnalytics.logAppOpen();

  void logSignIn() => _firebaseAnalytics.logLogin();

  void setUserId(String userId) => _firebaseAnalytics.setUserId(id: userId);

  void logVisitedScreenEvent({required String screenName, parameters = const <String, Object?>{}}) {
    _firebaseAnalytics.setCurrentScreen(screenName: screenName);
    logEvent(name: screenName, parameters: parameters);
  }

  void logEvent({
    required String name,
    required Map<String, Object?> parameters,
  }) {
    var params = Map<String, Object?>();
    params.addAll(parameters);
    params.putIfAbsent('appName', () => _appName);

    _firebaseAnalytics.logEvent(
      name: name,
      parameters: params,
    );
  }
}
