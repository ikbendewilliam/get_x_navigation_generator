import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class BasePage<T> extends GetPage<T> {
  BasePage({
    Transition? transition,
    required super.name,
    required super.page,
    super.title,
    super.participatesInRootNavigator,
    super.gestureWidth,
    super.maintainState,
    super.alignment,
    super.parameters,
    super.opaque,
    super.transitionDuration,
    super.popGesture,
    super.binding,
    super.bindings,
    super.customTransition,
    super.fullscreenDialog,
    super.children,
    super.middlewares,
    super.unknownRoute,
    super.arguments,
    super.preventDuplicates,
    super.showCupertinoParallax,
  }) : super(
          curve: Curves.bounceIn,
          transition: transition ?? Transition.circularReveal,
        );
}
