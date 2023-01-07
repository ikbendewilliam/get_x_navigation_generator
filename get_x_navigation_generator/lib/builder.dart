import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/get_x_navigation_config_generator.dart';
import 'src/generators/get_x_navigation_generator.dart';

Builder getXNavigationBuilder(BuilderOptions options) {
  return LibraryBuilder(
    const GetXNavigationGenerator(),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.get_x_navigation.json',
  );
}

Builder getXNavigationConfigBuilder(BuilderOptions options) {
  return LibraryBuilder(GetXNavigationConfigGenerator(),
      generatedExtension: '.g.dart');
}
