// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetXNavigationConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i3;
import 'package:get/route_manager.dart';

import 'main.dart' as _i4;
import 'middleware_example.dart' as _i6;
import 'second_page.dart' as _i5;
import 'some_model.dart' as _i1;
import 'third_page.dart' as _i2;

class BaseNavigator {
  static final pages = [
    GetPage<_i1.SomeModel?>(
      name: RouteNames.thirdPage,
      page: () => _i2.ThirdPage.withValue(
        previousValue: (Get.arguments?['previousValue'] as _i1.SomeModel?),
        key: (Get.arguments?['key'] as _i3.Key?),
      ),
    ),
    GetPage<dynamic>(
      name: RouteNames.firstPage,
      page: () => _i4.FirstPage(key: (Get.arguments?['key'] as _i3.Key?)),
    ),
    GetPage<bool>(
      name: RouteNames.customName,
      page: () => _i5.SecondPage(
        title: (Get.arguments?['title'] as String),
        subTitle: (Get.arguments?['subTitle'] as String?),
        key: (Get.arguments?['key'] as _i3.Key?),
      ),
      middlewares: [_i6.MiddlewareExample()],
    ),
  ];

  Future<_i1.SomeModel?> goToThirdPage({
    required _i1.SomeModel? previousValue,
    _i3.Key? key,
  }) async {
    final dynamic result = await Get.toNamed<dynamic>(
      RouteNames.thirdPage,
      arguments: {'previousValue': previousValue, 'key': key},
    );
    return (result as _i1.SomeModel?);
  }

  Future<void> goToFirstPage({_i3.Key? key}) async => Get.toNamed<dynamic>(
        RouteNames.firstPage,
        arguments: {'key': key},
      );
  Future<bool?> goToCustomName({
    required String title,
    String? subTitle,
    _i3.Key? key,
  }) async {
    final dynamic result = await Get.offAllNamed<dynamic>(
      RouteNames.customName,
      arguments: {'title': title, 'subTitle': subTitle, 'key': key},
    );
    return (result as bool?);
  }

  void goBack<T>({T? result}) => Get.back<T>(result: result);
  Future<T?> showCustomDialog<T>({_i3.Widget? widget}) async =>
      Get.dialog<T>(widget ?? const _i3.SizedBox.shrink());
}

class RouteNames {
  static const thirdPage = '/ThirdPage';

  static const firstPage = '/FirstPage';

  static const customName = '/custom-name';
}
