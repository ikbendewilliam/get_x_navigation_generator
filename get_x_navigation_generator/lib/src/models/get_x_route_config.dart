import 'package:get/get.dart';
import 'package:get_x_navigation_generator/src/models/importable_type.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

class GetXRouteConfig {
  final bool generateMethod;
  final bool generatePage;
  final bool isFullscreenDialog;
  final bool routeNameIsDefined;
  final bool preventDuplicates;
  final String routeName;
  final String constructorName;
  final ImportableType type;
  final ImportableType? returnType;
  final NavigationType? navigationType;
  final List<ImportableType> parameters;
  final List<ImportableType> middlewares;
  final ImportableType? customTransition;
  final Transition? transition;
  final Duration? transitionDuration;
  final bool? participatesInRootNavigator;
  final String? title;
  final bool maintainState;
  final bool opaque;
  final bool? popGesture;
  final bool showCupertinoParallax;

  GetXRouteConfig({
    required this.type,
    required this.routeName,
    required this.routeNameIsDefined,
    required this.preventDuplicates,
    required this.returnType,
    required this.constructorName,
    required this.navigationType,
    required this.parameters,
    required this.middlewares,
    required this.generateMethod,
    required this.generatePage,
    required this.isFullscreenDialog,
    required this.customTransition,
    required this.transition,
    required this.transitionDuration,
    required this.participatesInRootNavigator,
    required this.title,
    required this.maintainState,
    required this.opaque,
    required this.popGesture,
    required this.showCupertinoParallax,
  });

  String get navigationTypeAsString {
    switch (navigationType) {
      case NavigationType.pushAndReplaceAll:
        return 'offAllNamed';
      case NavigationType.popAndPush:
        return 'offNamed';
      case NavigationType.push:
      case null:
        return 'toNamed';
      case NavigationType.dialog:
        return 'dialog';
    }
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'type': type.toMap(),
      'returnType': returnType?.toMap(),
      'routeName': routeName,
      'routeNameIsDefined': routeNameIsDefined,
      'preventDuplicates': preventDuplicates,
      'constructorName': constructorName,
      'navigationType': navigationType?.index,
      'parameters': parameters.map((x) => x.toMap()).toList(),
      'middlewares': middlewares.map((x) => x.toMap()).toList(),
      'isFullscreenDialog': isFullscreenDialog,
      'generateMethod': generateMethod,
      'generatePage': generatePage,
      'customTransition': customTransition?.toMap(),
      'transition': transition,
      'transitionDuration': transitionDuration?.inMilliseconds,
      'participatesInRootNavigator': participatesInRootNavigator,
      'title': title,
      'maintainState': maintainState,
      'opaque': opaque,
      'popGesture': popGesture,
      'showCupertinoParallax': showCupertinoParallax,
    };
  }

  factory GetXRouteConfig.fromMap(Map<String, dynamic> map) {
    return GetXRouteConfig(
      type: ImportableType.fromMap(map['type'] as Map<String, dynamic>),
      returnType: map['returnType'] != null ? ImportableType.fromMap(map['returnType'] as Map<String, dynamic>) : null,
      routeName: map['routeName'] as String? ?? '',
      routeNameIsDefined: map['routeNameIsDefined'] as bool,
      preventDuplicates: map['preventDuplicates'] as bool,
      constructorName: map['constructorName'] as String? ?? '',
      navigationType: NavigationType.values.firstWhereOrNull((e) => e.index == map['navigationType']),
      parameters: List<ImportableType>.from(map['parameters']?.map((dynamic x) => ImportableType.fromMap(x as Map<String, dynamic>)) as Iterable),
      middlewares: List<ImportableType>.from(map['middlewares']?.map((dynamic x) => ImportableType.fromMap(x as Map<String, dynamic>)) as Iterable),
      isFullscreenDialog: map['isFullscreenDialog'] as bool,
      generateMethod: map['generateMethod'] as bool,
      generatePage: map['generatePage'] as bool,
      customTransition: map['customTransition'] != null ? ImportableType.fromMap(map['customTransition'] as Map<String, dynamic>) : null,
      transition: map['transition'] is int ? Transition.values[map['transition'] as int] : null,
      transitionDuration: map['transitionDuration'] == null ? null : Duration(milliseconds: map['transitionDuration'] as int),
      participatesInRootNavigator: map['participatesInRootNavigator'] as bool?,
      title: map['title'] as String?,
      maintainState: map['maintainState'] as bool,
      opaque: map['opaque'] as bool,
      popGesture: map['popGesture'] as bool?,
      showCupertinoParallax: map['showCupertinoParallax'] as bool,
    );
  }
}
