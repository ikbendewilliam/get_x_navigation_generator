// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetXNavigationConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/first_page.dart';
import 'package:example/second_page.dart';
import 'package:example/third_page.dart';
import 'package:flutter/material.dart' as _i2;
import 'package:get/route_manager.dart';

import 'some_model.dart' as _i1;

class BaseNavigator {
  static final pages = [
    GetPage(
      name: RouteNames.thirdPage,
      page: () => ThirdPage(
        previousValue: (Get.arguments['previousValue'] as _i1.SomeModel?),
        key: (Get.arguments['key'] as _i2.Key?),
      ),
    ),
    GetPage(
      name: RouteNames.customName,
      page: () => SecondPage(
        title: (Get.arguments['title'] as String),
        subTitle: (Get.arguments['subTitle'] as String?),
        key: (Get.arguments['key'] as _i2.Key?),
      ),
    ),
    GetPage(
      name: RouteNames.firstPage,
      page: () => FirstPage(key: (Get.arguments['key'] as _i2.Key?)),
    ),
  ];

  Future<_i1.SomeModel?> goToThirdPage({
    required _i1.SomeModel? previousValue,
    _i2.Key? key,
  }) async =>
      Get.toNamed<_i1.SomeModel?>(
        RouteNames.thirdPage,
        arguments: {'previousValue': previousValue, 'key': key},
      );
  Future<bool?> goToCustomName({
    required String title,
    String? subTitle,
    _i2.Key? key,
  }) async =>
      Get.toNamed<bool>(
        RouteNames.customName,
        arguments: {'title': title, 'subTitle': subTitle, 'key': key},
      );
  Future<void> goToFirstPage({_i2.Key? key}) async => Get.toNamed<void>(
        RouteNames.firstPage,
        arguments: {'key': key},
      );
}

class RouteNames {
  static const thirdPage = 'ThirdPage';

  static const customName = 'custom-name';

  static const firstPage = 'FirstPage';
}
