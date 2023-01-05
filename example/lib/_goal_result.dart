import 'package:example/first_page.dart';
import 'package:example/second_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class BaseNavigator {
  static final pages = [
    GetPage<void>(
      name: RouteNames.firstPage,
      page: () => const FirstPage(),
    ),
    GetPage<void>(
      name: RouteNames.secondPage,
      page: () => const SecondPage(),
    ),
  ];

  void goToFirstPage() async => Get.offNamed<void>(RouteNames.firstPage);

  void goToSecondPage() async => Get.offNamed<void>(RouteNames.secondPage);

  void goBack<T>({T? result}) async => Get.back<T>(result: result);

  Future<void> showCustomDialog<T>({Widget? widget}) async => Get.dialog<T>(widget ?? const SizedBox.shrink());
}

class RouteNames {
  static String firstPage = 'firstPage';
  static String secondPage = 'secondPage';
}
