// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// GetXNavigationConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:example/first_page.dart';
import 'package:example/second_page.dart';
import 'package:flutter/material.dart' as _i1;
import 'package:get/route_manager.dart';

class BaseNavigator {
  static final pages = [
    GetPage(name: RouteNames.customName, page: () => SecondPage()),
    GetPage(name: RouteNames.firstPage, page: () => FirstPage())
  ];

  goToCustomName({_i1.Key? key}) => Get.toNamed<void>(RouteNames.customName);
  goToFirstPage({_i1.Key? key}) => Get.toNamed<void>(RouteNames.firstPage);
}

class RouteNames {
  static const customName = 'custom-name';

  static const firstPage = 'FirstPage';
}
