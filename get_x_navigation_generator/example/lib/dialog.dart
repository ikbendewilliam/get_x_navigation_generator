import 'package:example/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

@GetXDialog(
  returnType: bool,
)
class SomeDialog extends StatelessWidget {
  final String title;
  final String? subTitle;

  const SomeDialog({
    required this.title,
    required this.subTitle,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Center(
        child: Column(
          children: [
            const Spacer(),
            Text('Title: $title'),
            const SizedBox(height: 4),
            Text('SubTitle: $subTitle'),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => MainNavigator.instance.goBack(result: true),
              child: const Text('Return true'),
            ),
            const SizedBox(height: 4),
            MaterialButton(
              onPressed: () => MainNavigator.instance.goBack(result: false),
              child: const Text('Return false'),
            ),
          ],
        ),
      ),
    );
  }
}
