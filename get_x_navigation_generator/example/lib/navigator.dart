import 'package:get_x_navigation_generator_interface/get_x_navigation_generator_interface.dart';

import 'navigator.g.dart';

@getXNavigator
class MainNavigator extends BaseNavigator {
  MainNavigator._();

  // Note: use GetIt or something similar to inject this rather than declaring a singleton here
  static final MainNavigator _instance = MainNavigator._();

  static MainNavigator get instance => _instance;

  static String get initialRoute => RouteNames.firstPage;

  static final pages = BaseNavigator.pages;
}
