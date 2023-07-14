import 'package:example/base_page.dart';
import 'package:example/main.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

import 'navigator.get_x_navigator.dart';

@GetXNavigator(
  navigatorClassName: 'GeneratedNavigator',
  pageType: BasePage,
)
class MainNavigator with GeneratedNavigator {
  MainNavigator._();

  // Note: use GetIt or something similar to inject this rather than declaring a singleton here
  static final MainNavigator _instance = MainNavigator._();

  static MainNavigator get instance => _instance;

  static String get initialRoute => RouteNames.firstPage;

  // You can add additional pages here, for example a default page with an empty route
  static final pages = [
    BasePage<dynamic>(
      name: '/',
      page: () => const FirstPage(),
    ),
    ...GeneratedNavigator.pages,
  ];

  // This is purely for the example app to show how to use a navigator id, most likely you will hardcode this
  // in the page that uses the navigator or have some logic to determine which navigator id to use
  static int? lastNavigatorId;
}
