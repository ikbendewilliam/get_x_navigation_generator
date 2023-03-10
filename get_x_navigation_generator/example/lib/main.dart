import 'dart:math';

import 'package:example/navigator.dart';
import 'package:example/some_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainNavigator.initialRoute,
      getPages: MainNavigator.pages,
    );
  }
}

@getXRoute
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  SomeModel? _result;
  bool? _resultDialog;

  Future<void> _goToThirdPage() async {
    final result = await MainNavigator.instance.goToThirdPage(
      previousValue: const SomeModel('Hello'),
    );
    setState(() {
      _result = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('First Page'),
      ),
      body: Center(
        child: Column(
          children: [
            const Spacer(),
            MaterialButton(
              onPressed: () => MainNavigator.instance.goToCustomName(
                title: 'Hello',
                subTitle: 'World',
              ),
              child: const Text('Go to second page'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: _goToThirdPage,
              child: const Text('Go to third page'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => MainNavigator.instance
                  .goToPageWithAnotherNavigator(
                      navigatorId: MainNavigator.lastNavigatorId),
              child: const Text(
                  'Go to page with another navigator (using local navigator)'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () => MainNavigator.instance.goToImplementedPage(
                someVariable: Random().nextBool(),
              ),
              child: const Text('Go to base/implemented page'),
            ),
            const SizedBox(height: 16),
            MaterialButton(
              onPressed: () async {
                _resultDialog = await MainNavigator.instance.showSomeDialog(
                  title: 'Hello',
                  subTitle: 'World',
                );
                setState(() {});
              },
              child: const Text('Open some dialog'),
            ),
            const SizedBox(height: 16),
            Text('Result: ${_result?.hello}'),
            Text('Result dialog: $_resultDialog'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
