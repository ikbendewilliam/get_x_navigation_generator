# GetXNavigationGenerator

[GetXNavigationGenerator](https://pub.dev/packages/get_x_navigation_generator) is a builder to generate a getX navigator for your pages with a simple annotation.

## Features

- Generates a navigator class with all the routes
- Generates a class with all the route names
- Generates a method to go to each route (customizable navigation method) with arguments
- Generates a method to show dialogs
- Generates a method to go back and show a dialog

## Getting Started

First add the dependencies:

```yaml
dependencies:
  get_x_navigation_generator_annotations: current_version

dev_dependencies:
  get_x_navigation_generator: current_version
```

Create a navigator file and annotate it with `@getXNavigator`:

```dart
@getXNavigator
class MainNavigator extends BaseNavigator {}
```

Then annotate your pages with `@getXRoute`:

```dart
@getXRoute
class FirstPage extends StatefulWidget {
  const FirstPage({super.key});
  ...
```

Run build runner and you get the following result:

```dart
class BaseNavigator {
  static final pages = [
    GetPage(
      name: RouteNames.firstPage,
      page: () => FirstPage(key: (Get.arguments?['key'] as Key?)),
    ),
  ];

  Future<void> goToFirstPage({Key? key}) async => Get.toNamed<dynamic>(
        RouteNames.firstPage,
        arguments: {'key': key},
      );

  void goBack<T>({T? result}) => Get.back<T>(result: result);
  Future<T?> showCustomDialog<T>({Widget? widget}) async => Get.dialog<T>(widget ?? const SizedBox.shrink());
}

class RouteNames {
  static const firstPage = '/first-page';
}
```

## Customization

### GetXNavigator

- `name`: The name of the navigator class. Default: `BaseNavigator`
- `pageType`: The type of the generated pages, must extend GetPage. Default: `GetPage`
- `removeSuffixes`: A list of suffixes to remove from the route name. Default: `['Page', 'Screen', 'View', 'Widget']`

### GetXRoute

- `routeName`: The name of the route. Default: `[className]` (converted to kebab-case, as [recommended by Google for urls](<https://developers.google.com/search/docs/crawling-indexing/url-structure#:~:text=Consider%20using%20hyphens%20to%20separate,(%20_%20)%20in%20your%20URLs.>))
- `returnType`: The return type of the route. Default: `void` (Note: `?` is not valid, use `returnTypeNullable` instead)
- `returnTypeNullable`: If the return type is nullable. Default: `false`
- `navigationType`: The type of navigation. Default: `NavigationType.push`, valid options are: `pushAndReplaceAll`, `popAndPush` and `push` and `dialog` to specify a dialog
- `middlewares`: A list of middleware types to use for the route. Default: `[]`. **Note:** an annotation needs to be constant and middlewares are not, so you need to pass the type of the middleware
- `generateMethod`: If a method should be generated for the route. Default: `true` (More info in separate method/page section below)
- `generatePage`: If a page should be generated for the route. Default: `true` (More info in separate method/page section below)
- `isFullscreenDialog`: If the route should be launched fullscreen. Default: `false`
- `customTransition`:  A custom transition to use for this route, needs to extend [CustomTransition]
- `transition`:  The transition to use for this route.
- `transitionDurationInMilliseconds`:  The duration of the transition to use for this route
- `participatesInRootNavigator`:  Whether this route participates in the root navigator
- `title`:  The title to use for this route
- `maintainState`:  Whether to maintain the state of this route
- `opaque`:  Whether this route is opaque
- `popGesture`:  Whether to enable the pop gesture for this route
- `showCupertinoParallax`: Whether to show the parallax effect on iOS

- `@getXRouteConstructor`: The constructor to use for the route. Defaults to unnamed constructor. This can be any constructor or static method

### GetXDialog

- `returnType`, `returnTypeNullable`, `routeName`, `isFullscreenDialog`: Same as `GetXRoute` (note: routeName is only used for the method name)

```dart
@GetXRoute(
  routeName: 'custom-name',
  returnType: bool,
  returnTypeNullable: true,
  navigationType: NavigationType.popAndPush,
  middlewares: [
    MiddlewareExample,
  ],
)
class FirstPage extends StatelessWidget {
    final int someValue;

    const FirstPage({required this.someValue, super.key});

    @getXRouteConstructor
    static FirstPage doubleValue(int someValue, {Key? key}) => FirstPage(someValue: someValue * 2, key: key);
```

## Separate method/page

For some projects, you may have multiple projects/packages/navigators and it can happen that you want to generate a method in a different navigator than the page.

An example would be a goToHelpScreen in a shared package and an implementation in different apps. In this case, you can use the `generateMethod` and `generatePage` options to generate only the method or only the page.

**Note** that the `routeName` must be the same for both the method and the page.

If you want to generate different arguments for the page than the base Widget has, you can use the `@getXRouteConstructor` annotation to specify a named constructor to use for the method arguments.

```dart
// In your shared package:
@GetXRoute(
  generatePage: false,
  routeName: '/help',
)
class BaseHelp extends StatelessWidget {
  final String appTitle;

  const BaseHelp({required this.appTitle, super.key});

  @getXRouteConstructor
  static BaseHelp.implementationConstructor()

...

// In your implementation:
@GetXRoute(
  generateMethod: false,
  routeName: '/help',
)
class Help extends StatelessWidget {
  const Help();

  Widget build(BuildContext context) {
    return BaseHelp(appTitle: 'My app');
  }
```

## Nested navigators

This package supports nested navigators. To use them, you need to specify a `id` for the navigator and use the `navigatorId` argument in the methods.

```dart
Navigator(
  key: Get.nestedKey(widget.id),
  onGenerateRoute: (settings) {
    final page = MainNavigator.pages.firstWhere((element) => element.name == settings.name);
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
);

...

_navigator.goToPageWithinNestedNavigation(navigatorId: widget.id);
```
