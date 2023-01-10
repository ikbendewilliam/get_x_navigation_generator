// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetXNavigationConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:get/route_manager.dart';

import 'base_page.dart' as _i1;
import 'main.dart' as _i5;
import 'middleware_example.dart' as _i7;
import 'second_page.dart' as _i6;
import 'some_model.dart' as _i2;
import 'third_page.dart' as _i3;

class GeneratedNavigator {
  static final pages = [
    _i1.BasePage<_i2.SomeModel?>(
      name: RouteNames.thirdPage,
      page: () => _i3.ThirdPage.withValue(
        previousValue: (Get.arguments?['previousValue'] as _i2.SomeModel?),
        key: (Get.arguments?['key'] as _i4.Key?),
      ),
    ),
    _i1.BasePage<dynamic>(
      name: RouteNames.firstPage,
      page: () => _i5.FirstPage(key: (Get.arguments?['key'] as _i4.Key?)),
    ),
    _i1.BasePage<bool>(
      name: RouteNames.customName,
      page: () => _i6.SecondPage(
        title: (Get.arguments?['title'] as String),
        subTitle: (Get.arguments?['subTitle'] as String?),
        key: (Get.arguments?['key'] as _i4.Key?),
      ),
      middlewares: [_i7.MiddlewareExample()],
    ),
  ];

  Future<_i2.SomeModel?> goToThirdPage({
    required _i2.SomeModel? previousValue,
    _i4.Key? key,
  }) async {
    final dynamic result = await Get.toNamed<dynamic>(
      RouteNames.thirdPage,
      arguments: {'previousValue': previousValue, 'key': key},
    );
    return (result as _i2.SomeModel?);
  }

  Future<void> goToFirstPage({_i4.Key? key}) async => Get.toNamed<dynamic>(
        RouteNames.firstPage,
        arguments: {'key': key},
      );
  Future<bool?> goToCustomName({
    required String title,
    String? subTitle,
    _i4.Key? key,
  }) async {
    final dynamic result = await Get.offAllNamed<dynamic>(
      RouteNames.customName,
      arguments: {'title': title, 'subTitle': subTitle, 'key': key},
    );
    return (result as bool?);
  }

  void goBack<T>({T? result}) => Get.back<T>(result: result);
  Future<T?> showCustomDialog<T>({_i4.Widget? widget}) async =>
      Get.dialog<T>(widget ?? const _i4.SizedBox.shrink());
}

class RouteNames {
  static const thirdPage = '/ThirdPage';

  static const firstPage = '/FirstPage';

  static const customName = '/custom-name';
}
