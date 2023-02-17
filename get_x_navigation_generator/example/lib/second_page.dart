import 'package:example/middleware_example.dart';
import 'package:example/navigator.dart';
import 'package:example/some_model.dart';
import 'package:flutter/material.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

@GetXRoute(
  routeName: 'custom-name',
  navigationType: NavigationType.pushAndReplaceAll,
  middlewares: [
    MiddlewareExample,
  ],
)
@getXRoute // Generate two routes: /second-page and /custom-name
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Second Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text('Title: $title'),
            const SizedBox(height: 4),
            Text('SubTitle: $subTitle'),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => MainNavigator.instance.goToFirstPage(),
              child: const Text('Go to first page'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => MainNavigator.instance.goToThirdPage(
                previousValue: const SomeModel('Hello from page 2'),
              ),
              child: const Text('Go to third page'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => MainNavigator.instance.showCustomDialog<void>(
                widget: const AlertDialog(
                  title: Text('Hello'),
                  content: Text('World'),
                ),
              ),
              child: const Text('Open a dialog'),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
