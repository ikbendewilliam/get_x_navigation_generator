/// Marks a class as a navigator and create
/// a base navigator class for it
class GetXNavigator {
  const GetXNavigator();
}

/// const instance of [InjectableInit]
/// with default arguments
const getXNavigator = GetXNavigator();

/// Marks a class as a get X route
class GetXRoute {
  /// Override the default name of the route
  final String? routeName;

  final NavigationType navigationType;

  const GetXRoute({
    this.navigationType = NavigationType.push,
    this.routeName,
  });
}

enum NavigationType {
  popAll,
  popAndPush,
  push,
}

/// const instance of [GetXRoute]
/// with default arguments
const getXRoute = GetXRoute();
