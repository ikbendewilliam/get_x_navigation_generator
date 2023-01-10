/// Marks a class as a navigator and create
/// a base navigator class for it
class GetXNavigator {
  /// The name of the navigator class to generate
  /// If not provided 'BaseNavigator' will be used
  final String? navigatorClassName;

  /// Override the default page type [GetPage] to
  /// use a custom page type so you can add custom
  /// arguments to the page. Must extend GetPage
  final Type? pageType;

  const GetXNavigator({
    this.navigatorClassName,
    this.pageType,
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

  /// The middlewares to use for this route
  /// Note: an annotation needs to be constant and middlewares are not,
  /// so you need to pass the type of the middleware
  final List<Type>? middlewares;

  const GetXRoute({
    this.navigationType = NavigationType.push,
    this.routeName,
    this.returnType,
    this.returnTypeNullable = false,
    this.middlewares,
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
