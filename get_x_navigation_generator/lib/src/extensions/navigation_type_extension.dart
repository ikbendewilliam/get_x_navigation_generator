import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

extension NavigationTypeExtension on NavigationType? {
  bool get isAsync {
    switch (this) {
      case NavigationType.push:
      case null:
        return true;
      case NavigationType.popAndPush:
      case NavigationType.pushAndReplaceAll:
        return false;
    }
  }
}
