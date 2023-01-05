// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetXNavigationConfigGenerator
// **************************************************************************

import 'package:example/first_page.dart';
import 'package:example/second_page.dart';
import 'package:get/route_manager.dart';

class BaseNavigator {
  static final pages = [
    GetPage(name: RouteNames.customName, page: () => SecondPage()),
    GetPage(name: RouteNames.firstPage, page: () => FirstPage())
  ];

  goToCustomName([Key]) => Get.toNamed<void>(RouteNames.customName);
  goToFirstPage([Key]) => Get.toNamed<void>(RouteNames.firstPage);
}

class RouteNames {
  static const customName = 'custom-name';

  static const firstPage = 'FirstPage';
}
