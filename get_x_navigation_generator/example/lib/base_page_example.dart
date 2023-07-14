import 'package:example/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/nav2/get_router_delegate.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

@GetXRoute(
  generatePage: false,
  isFullscreenDialog: true,
  routeName: '/implemented-page',
)
class BasePageExample extends StatelessWidget {
  final String title;

  const BasePageExample({
    required this.title,
    super.key,
  });

  @getXRouteConstructor
  const BasePageExample.implementationConstructor({
    required bool someVariable,
    super.key,
  }) : title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Base Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text(title),
            const SizedBox(height: 16),
            GetNavigator(pages: const []),
            MaterialButton(
              onPressed: () => MainNavigator.instance.goBack<void>(),
              child: const Text('Go back'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
