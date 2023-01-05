import 'package:flutter/material.dart';
import 'package:get_x_navigation_generator/get_x_navigation_generator.dart';

import 'goal.g.dart';

@getXNavigator
class MainNavigator extends BaseNavigator {
  static final List<NavigatorObserver> _navigatorObservers = [];

  static List<NavigatorObserver> get navigatorObservers => _navigatorObservers;

  static String get initialRoute => RouteNames.firstPage;

  static final pages = BaseNavigator.pages;
}
