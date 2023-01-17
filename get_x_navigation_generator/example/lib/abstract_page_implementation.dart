import 'package:example/base_page_example.dart';
import 'package:flutter/material.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

@GetXRoute(
  generateMethod: false,
  isFullscreenDialog: true,
  routeName: '/implemented-page',
)
class BasePageImplementation extends StatelessWidget {
  final bool someVariable;

  const BasePageImplementation({
    required this.someVariable,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BasePageExample(
        title: 'Implementation title, someVariable is $someVariable');
  }
}
