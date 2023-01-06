import 'package:example/some_model.dart';
import 'package:flutter/material.dart';
import 'package:get_x_navigation_generator/get_x_navigation_generator.dart';

@GetXRoute(
  returnType: SomeModel,
  returnTypeNullable: true,
)
class ThirdPage extends StatelessWidget {
  final String? title;

  const ThirdPage({
    required this.title,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
