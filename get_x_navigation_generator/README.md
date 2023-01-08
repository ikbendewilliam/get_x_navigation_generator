# GetXNavigationGenerator

[GetXNavigationGenerator](https://pub.dev/packages/get_x_navigation_generator) is a builder to generate a getX navigator for your pages with a simple annotation.

## Features

- Generates a navigator class with all the routes
- Generates a class with all the route names
- Generates a method to go to each route (customizable navigation method) with arguments
- Generates a method to go back and show a dialog

## Getting Started

First add the dependencies:

```yaml
dependencies:
  get_x_navigation_generator_interface: ^0.0.1

dev_dependencies:
  get_x_navigation_generator: ^0.0.1
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
  static const firstPage = '/FirstPage';
}
```

## Customization

### GetXNavigator

- `name`: The name of the navigator class. Default: `BaseNavigator`

### GetXRoute

- `routeName`: The name of the route. Default: `[className]`
- `returnType`: The return type of the route. Default: `void` (Note: `?` is not valid, use `returnTypeNullable` instead)
- `returnTypeNullable`: If the return type is nullable. Default: `false`
- `navigationType`: The type of navigation. Default: `NavigationType.push`, valid options are: `popAllAndPush`, `popAndPush` and `push`
- `middlewares`: A list of middleware types to use for the route. Default: `[]`. **Note:** an annotation needs to be constant and middlewares are not, so you need to pass the type of the middleware

- `@getXRouteConstructor`: The constructor to use for the route. Defaults to unnamed constructor. This can be any constructor or static method

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
