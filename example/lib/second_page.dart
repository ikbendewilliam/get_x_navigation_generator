import 'package:flutter/material.dart';
import 'package:get_x_navigation_generator/get_x_navigation_generator.dart';

@GetXRoute(
  routeName: 'custom-name',
  returnType: bool,
)
class SecondPage extends StatelessWidget {
  final String title;
  final String? subTitle;

  const SecondPage({
    required this.title,
    this.subTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
