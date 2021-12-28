import 'package:fresh9_rider/core/model/product.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:fresh9_rider/ui/router.dart';
import 'package:flutter/material.dart';
import 'package:fresh9_rider/locator.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';
import 'package:fresh9_rider/core/service/scroll_behavior.dart';
import 'package:fresh9_rider/core/app_config/app_config.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

AppConfig _appConfig = AppConfig();



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
//  await FirebaseAuth.instance.useEmulator('http://localhost:9099');
  setupLocator();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.red.shade300, // navigation bar color
    statusBarColor: Colors.red.shade300, // status bar color
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ChangeNotifierProvider<AppConfig>(
        create: (context) => _appConfig,
        child: Consumer<AppConfig>(builder: (context, appConfig, child) {
          return StreamProvider<List<Product>>(
              create: (context) => locator<CartService>().cartController,
              updateShouldNotify: (_, __) => true,
              initialData: List<Product>(),
              child: MaterialApp(
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
              ));
        }));
  }
}

// found in the LICENSE file.

/// UI Widget for displaying metadata.
class MetaCard extends StatelessWidget {
  final String _title;
  final Widget _children;

  // ignore: public_member_api_docs
  MetaCard(this._title, this._children);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child:
                          Text(_title, style: const TextStyle(fontSize: 18))),
                  _children,
                ]))));
  }
}
