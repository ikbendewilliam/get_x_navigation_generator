import 'dart:math';

import 'package:example/navigator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_x_navigation_generator_annotations/get_x_navigation_generator_annotations.dart';

@getXRoute
class PageWithAnotherNavigator extends StatefulWidget {
  final id = Random().nextInt(999);

  PageWithAnotherNavigator({super.key}) {
    MainNavigator.lastNavigatorId = id;
  }

  @override
  State<PageWithAnotherNavigator> createState() =>
      _PageWithAnotherNavigatorState();
}

class _PageWithAnotherNavigatorState extends State<PageWithAnotherNavigator> {
  @override
  void dispose() {
    MainNavigator.lastNavigatorId = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page with another Navigator'),
      ),
      body: Container(
        color: Colors.primaries[widget.id % Colors.primaries.length],
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Navigator(
          key: Get.nestedKey(widget.id),
          onGenerateRoute: (settings) {
            final page = MainNavigator.pages
                .firstWhere((element) => element.name == settings.name);
            return GetPageRoute<dynamic>(
              page: page.page,
              settings: settings,
              binding: page.binding,
              transition: page.transition,
              opaque: page.opaque,
              popGesture: page.popGesture,
              fullscreenDialog: page.fullscreenDialog,
              maintainState: page.maintainState,
              curve: page.curve,
              middlewares: page.middlewares,
            );
          },
        ),
      ),
    );
  }
}
