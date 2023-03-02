// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetXNavigationConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:get/route_manager.dart';

import 'abstract_page_implementation.dart' as _i8;
import 'base_page.dart' as _i1;
import 'dialog.dart' as _i9;
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
    _i1.BasePage<dynamic>(
      name: RouteNames.customName,
      page: () => _i6.SecondPage(
        title: (Get.arguments?['title'] as String),
        subTitle: (Get.arguments?['subTitle'] as String?),
        key: (Get.arguments?['key'] as _i4.Key?),
      ),
      middlewares: [_i7.MiddlewareExample()],
    ),
    _i1.BasePage<dynamic>(
      name: RouteNames.secondPage,
      page: () => _i6.SecondPage(
        title: (Get.arguments?['title'] as String),
        subTitle: (Get.arguments?['subTitle'] as String?),
        key: (Get.arguments?['key'] as _i4.Key?),
      ),
    ),
    _i1.BasePage<dynamic>(
      name: RouteNames.implementedPage,
      page: () => _i8.BasePageImplementation(
        someVariable: (Get.arguments?['someVariable'] as bool),
        key: (Get.arguments?['key'] as _i4.Key?),
      ),
      fullscreenDialog: true,
    ),
  ];

  Future<void> goToImplementedPage({
    required bool someVariable,
    _i4.Key? key,
  }) async =>
      Get.toNamed<dynamic>(
        RouteNames.implementedPage,
        arguments: {'someVariable': someVariable, 'key': key},
      );
  Future<_i2.SomeModel?> goToThirdPage({
    required _i2.SomeModel? previousValue,
    _i4.Key? key,
  }) async {
    final dynamic result = await Get.offNamed<dynamic>(
      RouteNames.thirdPage,
      arguments: {'previousValue': previousValue, 'key': key},
    );
    return (result as _i2.SomeModel?);
  }

  Future<void> goToFirstPage({_i4.Key? key}) async => Get.toNamed<dynamic>(
        RouteNames.firstPage,
        arguments: {'key': key},
      );
  void goToCustomName({
    required String title,
    String? subTitle,
    _i4.Key? key,
  }) =>
      Get.offAllNamed<dynamic>(
        RouteNames.customName,
        arguments: {'title': title, 'subTitle': subTitle, 'key': key},
      );
  Future<void> goToSecondPage({
    required String title,
    String? subTitle,
    _i4.Key? key,
  }) async =>
      Get.toNamed<dynamic>(
        RouteNames.secondPage,
        arguments: {'title': title, 'subTitle': subTitle, 'key': key},
      );
  Future<bool?> showSomeDialog({
    required String title,
    required String? subTitle,
    _i4.Key? key,
  }) async =>
      showCustomDialog<bool>(
          widget: _i9.SomeDialog(
        title: title,
        subTitle: subTitle,
        key: key,
      ));
  void goBack<T>({T? result}) => Get.back<T>(result: result);
  void closeDialog() => goBack<void>();
  void popUntil(bool Function(_i4.Route<dynamic>) predicate) =>
      Get.until(predicate);
  void goBackTo(String routeName) =>
      Get.until((route) => Get.currentRoute == routeName);
  Future<T?> showCustomDialog<T>({_i4.Widget? widget}) async =>
      Get.dialog<T>(widget ?? const _i4.SizedBox.shrink());
}

class RouteNames {
  static const implementedPage = '/implemented-page';

  static const thirdPage = '/third';

  static const firstPage = '/first';

  static const customName = '/custom-name';

  static const secondPage = '/second';
}
