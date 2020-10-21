import 'package:Product/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:Product/locator.dart';
import 'package:Product/core/service/navigation_service.dart';
import 'package:Product/core/service/scroll_behavior.dart';
import 'package:Product/core/app_config/app_config.dart';


AppConfig _appConfig = AppConfig();

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Fresh9 Store',
      onGenerateRoute: NavigationRouter.generateRoute,
      initialRoute: NavigationRouter.splashScreen,
      navigatorKey: locator<NavigationService>().navigatorKey,
      theme: _appConfig.themeData,
      builder: (context, child) {
        return ScrollConfiguration(
          behavior: RemoveScrollGlow(),
          child: child,
        );
      },
    );
  }
}
