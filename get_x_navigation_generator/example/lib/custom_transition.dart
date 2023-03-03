import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExampleCustomTransition extends CustomTransition {
  @override
  Widget buildTransition(
      BuildContext context,
      Curve? curve,
      Alignment? alignment,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child) {
    return Stack(children: [
      Positioned.fill(
        child: Container(
          color: Colors.blue,
        ),
      ),
      Opacity(
        opacity: animation.value,
        child: child,
      ),
    ]);
  }
}
