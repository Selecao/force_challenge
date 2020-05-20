import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:forcechallenge/components/application/app_theme.dart';

class AApp extends StatefulWidget {
  const AApp({
    Key key,
    this.navigatorKey,
    this.home,
    this.theme,
    this.routes = const <String, WidgetBuilder>{},
    this.initialRoute,
    this.onGenerateRoute,
    this.onUnknownRoute,
    this.navigatorObservers = const <NavigatorObserver>[],
    this.builder,
    this.title = '',
    this.onGenerateTitle,
    this.color,
    this.locale,
    this.localizationsDelegates,
    this.localeListResolutionCallback,
    this.localeResolutionCallback,
    this.supportedLocales = const <Locale>[Locale('en', 'US')],
    this.showPerformanceOverlay = false,
    this.checkerboardRasterCacheImages = false,
    this.checkerboardOffscreenLayers = false,
    this.showSemanticsDebugger = false,
    this.debugShowCheckedModeBanner = true,
  })  : assert(routes != null),
        assert(navigatorObservers != null),
        assert(title != null),
        assert(showPerformanceOverlay != null),
        assert(checkerboardRasterCacheImages != null),
        assert(checkerboardOffscreenLayers != null),
        assert(showSemanticsDebugger != null),
        assert(debugShowCheckedModeBanner != null),
        super(key: key);

  final GlobalKey<NavigatorState> navigatorKey;

  final Widget home;

  final AppThemeData theme;

  final Map<String, WidgetBuilder> routes;

  final String initialRoute;

  final RouteFactory onGenerateRoute;

  final RouteFactory onUnknownRoute;

  final List<NavigatorObserver> navigatorObservers;

  final TransitionBuilder builder;

  final String title;

  final GenerateAppTitle onGenerateTitle;

  final Color color;

  final Locale locale;

  final Iterable<LocalizationsDelegate<dynamic>> localizationsDelegates;

  final LocaleListResolutionCallback localeListResolutionCallback;

  final LocaleResolutionCallback localeResolutionCallback;

  final Iterable<Locale> supportedLocales;

  final bool showPerformanceOverlay;

  final bool checkerboardRasterCacheImages;

  final bool checkerboardOffscreenLayers;

  final bool showSemanticsDebugger;

  final bool debugShowCheckedModeBanner;

  @override
  AAppState createState() => AAppState();

  static HeroController createHeroController() => HeroController();
}

class _AlwaysCupertinoScrollBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    // Never build any overscroll glow indicators.
    return child;
  }

  @override
  ScrollPhysics getScrollPhysics(BuildContext context) {
    return const BouncingScrollPhysics();
  }
}

class AAppState extends State<AApp> {
  HeroController _heroController;

  @override
  void initState() {
    super.initState();
    _heroController = AApp.createHeroController();
    _updateNavigator();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void didUpdateWidget(AApp oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.navigatorKey != oldWidget.navigatorKey) {
      // If the Navigator changes, we have to create a new observer, because the
      // old Navigator won't be disposed (and thus won't unregister with its
      // observers) until after the new one has been created (because the
      // Navigator has a GlobalKey).
      _heroController = AApp.createHeroController();
    }
    _updateNavigator();
  }

  List<NavigatorObserver> _navigatorObservers;

  void _updateNavigator() {
    if (widget.home != null ||
        widget.routes.isNotEmpty ||
        widget.onGenerateRoute != null ||
        widget.onUnknownRoute != null) {
      _navigatorObservers =
          List<NavigatorObserver>.from(widget.navigatorObservers)
            ..add(_heroController);
    } else {
      _navigatorObservers = const <NavigatorObserver>[];
    }
  }

  // Combine the default localization for Cupertino with the ones contributed
  // by th localizationsDelegates parameter, if any. Only the first delegate
  // of a particular LocalizationsDelegate.type is loaded so the
  // localizationDelegate parameter can be used to override
  // _CupertinoLocalizationsDelegate.
  Iterable<LocalizationsDelegate<dynamic>> get _localizationsDelegate sync* {
    if (widget.localizationsDelegates != null)
      yield* widget.localizationsDelegates;
    yield DefaultCupertinoLocalizations.delegate;
    yield DefaultMaterialLocalizations.delegate;
  }

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: _AlwaysCupertinoScrollBehavior(),
      child: AppTheme(
        data: widget.theme,
        child: CupertinoTheme(
          data: CupertinoThemeData(
            scaffoldBackgroundColor: AppTheme.of(context).whiteColor,
            textTheme: CupertinoTextThemeData(
              textStyle: TextStyle(fontFamily: widget.theme.defaultFontFamily),
            ),
          ),
          child: IconTheme(
            data: IconThemeData(
              color: widget.theme.blueMainColor,
              size: 16,
            ),
            child: WidgetsApp(
              key: GlobalObjectKey(this),
              navigatorKey: widget.navigatorKey,
              navigatorObservers: _navigatorObservers,
              pageRouteBuilder: <T>(RouteSettings settings,
                      WidgetBuilder builder) =>
                  CupertinoPageRoute<T>(settings: settings, builder: builder),
              home: widget.home,
              routes: widget.routes,
              initialRoute: widget.initialRoute,
              onGenerateRoute: widget.onGenerateRoute,
              onUnknownRoute: widget.onUnknownRoute,
              builder: widget.builder,
              title: widget.title,
              onGenerateTitle: widget.onGenerateTitle,
              textStyle: widget.theme.bodyLightTextStyle,
              color: widget.color ?? CupertinoColors.activeBlue,
              locale: widget.locale,
              localizationsDelegates: _localizationsDelegate,
              localeResolutionCallback: widget.localeResolutionCallback,
              localeListResolutionCallback: widget.localeListResolutionCallback,
              supportedLocales: widget.supportedLocales,
              showPerformanceOverlay: widget.showPerformanceOverlay,
              checkerboardRasterCacheImages:
                  widget.checkerboardRasterCacheImages,
              checkerboardOffscreenLayers: widget.checkerboardOffscreenLayers,
              showSemanticsDebugger: widget.showSemanticsDebugger,
              debugShowCheckedModeBanner: widget.debugShowCheckedModeBanner,
              inspectorSelectButtonBuilder:
                  (BuildContext context, VoidCallback onPressed) {
                return CupertinoButton.filled(
                  child: const Icon(
                    CupertinoIcons.search,
                    size: 28.0,
                    color: CupertinoColors.white,
                  ),
                  padding: EdgeInsets.zero,
                  onPressed: onPressed,
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
