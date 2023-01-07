import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/get_x_navigation_config_generator.dart';
import 'src/generators/get_x_navigation_generator.dart';

/// A builder that generates a json file for one or more routes.
Builder getXNavigationBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const GetXNavigationGenerator(),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.get_x_navigation.json',
  );
}

/// A builder that generates the navigator class.
Builder getXNavigationConfigBuilder(BuilderOptions options) {
  return LibraryBuilder(GetXNavigationConfigGenerator(), generatedExtension: '.g.dart');
}
