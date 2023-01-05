import 'dart:async';

// MicroPackage initializers will implement this class
// to be later used in the main initializer
abstract class MicroPackageModule {
  /// registers dependencies inside of get it
  FutureOr<void> init(dynamic gh);
}
