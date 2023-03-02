import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

extension RouteTransitionExtension on RouteTransition {
  String get transition => _transitionMap[this]!;

  static const _transitionMap = {
    RouteTransition.fade: 'Transition.fade',
    RouteTransition.fadeIn: 'Transition.fadeIn',
    RouteTransition.rightToLeft: 'Transition.rightToLeft',
    RouteTransition.leftToRight: 'Transition.leftToRight',
    RouteTransition.upToDown: 'Transition.upToDown',
    RouteTransition.downToUp: 'Transition.downToUp',
    RouteTransition.rightToLeftWithFade: 'Transition.rightToLeftWithFade',
    RouteTransition.leftToRightWithFade: 'Transition.leftToRightWithFade',
    RouteTransition.zoom: 'Transition.zoom',
    RouteTransition.topLevel: 'Transition.topLevel',
    RouteTransition.noTransition: 'Transition.noTransition',
    RouteTransition.cupertino: 'Transition.cupertino',
    RouteTransition.cupertinoDialog: 'Transition.cupertinoDialog',
    RouteTransition.size: 'Transition.size',
    RouteTransition.circularReveal: 'Transition.circularReveal',
    RouteTransition.native: 'Transition.native',
  };
}
