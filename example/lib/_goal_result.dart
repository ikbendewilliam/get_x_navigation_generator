import 'package:example/first_page.dart';
import 'package:example/second_page.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class BaseNavigator {
  static final pages = [
    GetPage<void>(
      name: RouteNames.firstPage,
      page: () => FirstPage(
        key: Get.arguments['key'] as Key?,
      ),
    ),
    GetPage<void>(
      name: RouteNames.secondPage,
      page: () => const SecondPage(title: 'title'),
    ),
  ];

  void goToFirstPage({Key? key}) async => Get.toNamed<void>(RouteNames.firstPage, arguments: {'key': key});

  void goToSecondPage() async => Get.toNamed<void>(RouteNames.secondPage);

  void goBack<T>({T? result}) async => Get.back<T>(result: result);

  Future<void> showCustomDialog<T>({Widget? widget}) async => Get.dialog<T>(widget ?? const SizedBox.shrink());
}

class RouteNames {
  static String firstPage = 'firstPage';
  static String secondPage = 'secondPage';
}
