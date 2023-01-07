/// Marks a class as a navigator and create
/// a base navigator class for it
class GetXNavigator {
  /// The name of the navigator class to generate
  /// If not provided 'BaseNavigator' will be used
  final String? navigatorClassName;

  const GetXNavigator({
    this.navigatorClassName,
  });
}

/// const instance of [InjectableInit]
/// with default arguments
const getXNavigator = GetXNavigator();

/// Marks a class as a get X route, a page and method will be generated
class GetXRoute {
  /// Override the default name of the route
  final String? routeName;

  /// Set the type returned by the goTo method.
  /// If the type is nullable, set [returnTypeNullable] to true
  final Type? returnType;

  /// Set if the type returned by the goTo method is nullable
  final bool returnTypeNullable;

  /// The type of navigation to use
  final NavigationType navigationType;

  const GetXRoute({
    this.navigationType = NavigationType.push,
    this.routeName,
    this.returnType,
    this.returnTypeNullable = false,
  });
}

/// const instance of [GetXRoute]
/// with default arguments
const getXRoute = GetXRoute();

/// The type of navigation to use
enum NavigationType {
  /// Pop all previous routes and push the new route
  popAllAndPush,

  /// Pop the current route and push the new route
  popAndPush,

  /// Push the new route
  push,
}

/// The constructor or static method to use to create a get X route
/// The arguments will be used to generate the goTo method
class GetXRouteConstructor {
  const GetXRouteConstructor();
}

/// const instance of [GetXRouteConstructor]
const getXRouteConstructor = GetXRouteConstructor();
