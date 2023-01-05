import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'src/generators/injectable_config_generator.dart';
import 'src/generators/injectable_generator.dart';

Builder getXNavigationBuilder(BuilderOptions options) {
  return LibraryBuilder(
    InjectableGenerator(options.config),
    formatOutput: (generated) => generated.replaceAll(RegExp(r'//.*|\s'), ''),
    generatedExtension: '.get_x_navigation.json',
  );
}

Builder getXNavigationConfigBuilder(BuilderOptions options) {
  return LibraryBuilder(InjectableConfigGenerator(), generatedExtension: '.g.dart', additionalOutputExtensions: ['.module.dart']);
}
