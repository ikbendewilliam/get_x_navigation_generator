import 'package:example/base_page.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

import 'navigator.get_x_navigator.dart';

@GetXNavigator(
  navigatorClassName: 'GeneratedNavigator',
  pageType: BasePage,
)
class MainNavigator extends GeneratedNavigator {
  MainNavigator._();

  // Note: use GetIt or something similar to inject this rather than declaring a singleton here
  static final MainNavigator _instance = MainNavigator._();

  static MainNavigator get instance => _instance;

  static String get initialRoute => RouteNames.firstPage;

  static final pages = GeneratedNavigator.pages;
}
