import 'package:example/custom_transition.dart';
import 'package:example/navigator.dart';
import 'package:example/some_model.dart';
import 'package:flutter/material.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

@GetXRoute(
  returnType: SomeModel,
  customTransition: ExampleCustomTransition,
)
class ThirdPage extends StatelessWidget {
  final SomeModel? previousValue;
  final String aStringWithDefaultValue;
  final bool aBoolWithDefaultValue;
  final bool anotherBoolWithDefaultValue;

  const ThirdPage({
    required this.aStringWithDefaultValue,
    required this.aBoolWithDefaultValue,
    required this.anotherBoolWithDefaultValue,
    super.key,
  }) : previousValue = null;

  const ThirdPage._withValue({
    required this.previousValue,
    required this.aStringWithDefaultValue,
    required this.aBoolWithDefaultValue,
    required this.anotherBoolWithDefaultValue,
    super.key,
  });

  @getXRouteConstructor
  static ThirdPage withValue({
    required SomeModel? previousValue,
    String aStringWithDefaultValue = '',
    bool aBoolWithDefaultValue = false,
    bool anotherBoolWithDefaultValue = 'Hello' == 'Hello',
    Key? key,
  }) =>
      ThirdPage._withValue(
        previousValue: previousValue,
        aStringWithDefaultValue: aStringWithDefaultValue,
        aBoolWithDefaultValue: aBoolWithDefaultValue,
        anotherBoolWithDefaultValue: anotherBoolWithDefaultValue,
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
