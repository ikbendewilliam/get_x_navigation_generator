// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetXNavigationConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i4;
import 'package:get/route_manager.dart' as _i8;
import 'package:get/route_manager.dart';

import 'abstract_page_implementation.dart' as _i10;
import 'base_page.dart' as _i1;
import 'dialog.dart' as _i11;
import 'main.dart' as _i5;
import 'middleware_example.dart' as _i7;
import 'page_with_another_navigator.dart' as _i9;
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
      transition: _i8.Transition.zoom,
      transitionDuration: const Duration(milliseconds: 1000),
      participatesInRootNavigator: true,
      title: 'SecondPage',
      maintainState: false,
      opaque: false,
      showCupertinoParallax: true,
      popGesture: true,
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
      name: RouteNames.pageWithAnotherNavigator,
      page: () => _i9.PageWithAnotherNavigator(
          key: (Get.arguments?['key'] as _i4.Key?)),
    ),
    _i1.BasePage<dynamic>(
      name: RouteNames.implementedPage,
      page: () => _i10.BasePageImplementation(
        someVariable: (Get.arguments?['someVariable'] as bool),
        key: (Get.arguments?['key'] as _i4.Key?),
      ),
      fullscreenDialog: true,
    ),
  ];

  Future<void> goToImplementedPage({
    required bool someVariable,
    _i4.Key? key,
    int? navigatorId,
  }) async =>
      Get.toNamed<dynamic>(
        RouteNames.implementedPage,
        id: navigatorId,
        arguments: {'someVariable': someVariable, 'key': key},
        preventDuplicates: false,
      );
  Future<_i2.SomeModel?> goToThirdPage({
    required _i2.SomeModel? previousValue,
    _i4.Key? key,
    int? navigatorId,
  }) async {
    final dynamic result = await Get.toNamed<dynamic>(
      RouteNames.thirdPage,
      id: navigatorId,
      arguments: {'previousValue': previousValue, 'key': key},
      preventDuplicates: false,
    );
    return (result as _i2.SomeModel?);
  }

  Future<void> goToFirstPage({
    _i4.Key? key,
    int? navigatorId,
  }) async =>
      Get.toNamed<dynamic>(
        RouteNames.firstPage,
        id: navigatorId,
        arguments: {'key': key},
        preventDuplicates: false,
      );
  void goToCustomName({
    required String title,
    String? subTitle,
    _i4.Key? key,
    int? navigatorId,
  }) =>
      Get.offAllNamed<dynamic>(
        RouteNames.customName,
        id: navigatorId,
        arguments: {'title': title, 'subTitle': subTitle, 'key': key},
      );
  Future<void> goToSecondPage({
    required String title,
    String? subTitle,
    _i4.Key? key,
    int? navigatorId,
  }) async =>
      Get.toNamed<dynamic>(
        RouteNames.secondPage,
        id: navigatorId,
        arguments: {'title': title, 'subTitle': subTitle, 'key': key},
        preventDuplicates: false,
      );
  Future<void> goToPageWithAnotherNavigator({
    _i4.Key? key,
    int? navigatorId,
  }) async =>
      Get.toNamed<dynamic>(
        RouteNames.pageWithAnotherNavigator,
        id: navigatorId,
        arguments: {'key': key},
        preventDuplicates: false,
      );
  Future<bool?> showSomeDialog({
    required String title,
    required String? subTitle,
    _i4.Key? key,
    _i4.GlobalKey<_i4.NavigatorState>? navigatorKey,
  }) async =>
      showCustomDialog<bool>(
        navigatorKey: navigatorKey,
        widget: _i11.SomeDialog(
          title: title,
          subTitle: subTitle,
          key: key,
        ),
      );
  void goBack<T>({
    T? result,
    int? navigatorId,
  }) =>
      Get.back<T>(
        result: result,
        id: navigatorId,
      );
  void closeDialog({int? navigatorId}) =>
      goBack<void>(navigatorId: navigatorId);
  void popUntil(
    bool Function(_i4.Route<dynamic>) predicate, {
    int? navigatorId,
  }) =>
      Get.until(
        predicate,
        id: navigatorId,
      );
  void goBackTo(
    String routeName, {
    int? navigatorId,
  }) =>
      Get.until(
        (route) => Get.currentRoute == routeName,
        id: navigatorId,
      );
  Future<T?> showCustomDialog<T>({
    _i4.Widget? widget,
    _i4.GlobalKey<_i4.NavigatorState>? navigatorKey,
  }) async =>
      Get.dialog<T>(
        widget ?? const _i4.SizedBox.shrink(),
        navigatorKey: navigatorKey,
      );
}

class RouteNames {
  static const implementedPage = '/implemented-page';

  static const thirdPage = '/third';

  static const firstPage = '/first';

  static const customName = '/custom-name';

  static const secondPage = '/second';

  static const pageWithAnotherNavigator = '/page-with-another-navigator';
}
