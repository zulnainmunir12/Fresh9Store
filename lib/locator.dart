import 'package:get_it/get_it.dart';
//import 'package:quiznoscr/core/service/api.dart';
import 'package:Product/core/service/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
//  locator.registerFactory(() => Api());
  locator.registerLazySingleton(() => NavigationService());
}