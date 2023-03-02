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

  /// Remove the suffixes from the class name in
  /// the routename. Does not effect custom route names
  final List<String> removeSuffixes;

  const GetXNavigator({
    this.navigatorClassName,
    this.pageType,
    this.removeSuffixes = const ['Page', 'Screen', 'View', 'Widget'],
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

  /// Set if we allow duplicates of this route. Note that nested
  /// routes are also considered duplicates.
  final bool preventDuplicates;

  /// The type of navigation to use
  final NavigationType navigationType;

  /// The middlewares to use for this route
  /// Note: an annotation needs to be constant and middlewares are not,
  /// so you need to pass the type of the middleware
  final List<Type>? middlewares;

  /// Open the route in fullscreen mode
  final bool isFullscreenDialog;

  /// Enable/Disable the generation of the page, use this if you separate the
  /// declaration of the page and the method. This is useful if you have
  /// a shared package that declares the method and a project that declares
  /// the page.
  ///
  /// **Note** that the routeName has to match with the generated method routeName
  ///
  /// if the page has different arguments than the method, you can create a
  /// named constructor and add the [@getXRouteConstructor] annotation to the BaseWidget
  final bool generatePage;

  /// Enable/Disable the generation of the method, use this if you separate the
  /// declaration of the page and the method. This is useful if you have
  /// a shared package that declares the method and a project that declares
  /// the page.
  ///
  /// **Note** that the routeName has to match with the generated page routeName
  ///
  /// if the page has different arguments than the method, you can create a
  /// named constructor and add the [@getXRouteConstructor] annotation to the BaseWidget
  final bool generateMethod;

  const GetXRoute({
    this.navigationType = NavigationType.push,
    this.routeName,
    this.returnType,
    this.middlewares,
    this.returnTypeNullable = false,
    this.isFullscreenDialog = false,
    this.generatePage = true,
    this.generateMethod = true,
    this.preventDuplicates = false,
  });
}

/// const instance of [GetXRoute]
/// with default arguments
const getXRoute = GetXRoute();

/// Marks a class as a get X dialog
/// A method will be generated
/// Similar to [GetXRoute] with navigationType = NavigationType.dialog
class GetXDialog extends GetXRoute {
  const GetXDialog({
    String? routeName,
    Type? returnType,
    bool returnTypeNullable = false,
  }) : super(
          routeName: routeName,
          returnType: returnType,
          returnTypeNullable: returnTypeNullable,
          isFullscreenDialog: true,
          middlewares: const [],
          navigationType: NavigationType.dialog,
          generatePage: false,
          generateMethod: true,
        );
}

/// const instance of [GetXDialog]
/// with default arguments
const getXDialog = GetXDialog();

/// The type of navigation to use
enum NavigationType {
  /// Pop all previous routes and push the new route
  pushAndReplaceAll,

  /// Pop the current route and push the new route
  popAndPush,

  /// Push the new route
  push,

  /// Create a dialog
  dialog,
}

/// The constructor or static method to use to create a get X route
/// The arguments will be used to generate the goTo method
class GetXRouteConstructor {
  const GetXRouteConstructor();
}

/// const instance of [GetXRouteConstructor]
const getXRouteConstructor = GetXRouteConstructor();
