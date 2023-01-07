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

/// Marks a class as a get X route
class GetXRoute {
  /// Override the default name of the route
  final String? routeName;
  final Type? returnType;
  final bool returnTypeNullable;
  final NavigationType navigationType;

  const GetXRoute({
    this.navigationType = NavigationType.push,
    this.routeName,
    this.returnType,
    this.returnTypeNullable = false,
  });
}

enum NavigationType {
  popAllAndPush,
  popAndPush,
  push,
}

/// const instance of [GetXRoute]
/// with default arguments
const getXRoute = GetXRoute();

class GetXRouteConstructor {
  const GetXRouteConstructor();
}

const getXRouteConstructor = GetXRouteConstructor();
