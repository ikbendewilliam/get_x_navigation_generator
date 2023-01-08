import 'package:example/navigator.dart';
import 'package:example/some_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_x_navigation_generator_interface/get_x_navigation_generator_interface.dart';

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
              onPressed: () => MainNavigator.instance.showCustomDialog<void>(
                widget: const AlertDialog(
                  title: Text('Hello'),
                  content: Text('World'),
                ),
              ),
              child: const Text('Open a dialog'),
            ),
            const SizedBox(height: 16),
            Text('Result: ${_result?.hello}'),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
