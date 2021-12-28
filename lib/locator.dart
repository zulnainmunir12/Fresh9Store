import 'package:fresh9_rider/core/service/auth_service.dart';
import 'package:fresh9_rider/core/service/cart_service.dart';
import 'package:get_it/get_it.dart';
import 'package:fresh9_rider/core/service/api.dart';
import 'package:fresh9_rider/core/service/navigation_service.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerFactory(() => Api());
  locator.registerLazySingleton(() => NavigationService());
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => CartService());
}