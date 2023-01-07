import 'package:example/navigator.dart';
import 'package:example/some_model.dart';
import 'package:flutter/material.dart';
import 'package:get_x_navigation_generator_interface/get_x_navigation_generator_interface.dart';

@GetXRoute(
  returnType: SomeModel,
  returnTypeNullable: true,
)
class ThirdPage extends StatelessWidget {
  final SomeModel? previousValue;

  const ThirdPage({
    super.key,
  }) : previousValue = null;

  const ThirdPage._withValue({
    required this.previousValue,
    super.key,
  });

  @getXRouteConstructor
  static ThirdPage withValue({
    required SomeModel? previousValue,
    Key? key,
  }) =>
      ThirdPage._withValue(
        previousValue: previousValue,
        key: key,
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Third Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            Text('Got data: ${previousValue?.hello}'),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () =>
                  MainNavigator.instance.goBack(result: previousValue),
              child: const Text('Go back'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => MainNavigator.instance.showCustomDialog(
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
