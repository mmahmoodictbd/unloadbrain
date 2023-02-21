import 'package:chumbok_apps/common/app_router.dart';
import 'package:chumbok_apps/common/app_specific_context.dart';
import 'package:chumbok_apps/kobita_app/kobita_app_router.dart';

class KobitaAppSpecificContext implements AppSpecificContext {
  @override
  AppRouter getAppRouter() {
    return KobitaAppRouter();
  }
}
