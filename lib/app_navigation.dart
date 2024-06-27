import 'package:ebook_flutter/pages/detail_book_page.dart';
import 'package:ebook_flutter/pages/favourite_page.dart';
import 'package:ebook_flutter/pages/home_page.dart';
import 'package:ebook_flutter/pages/mainwrapper.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigation {
  AppNavigation._();

  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorHome = GlobalKey<NavigatorState>(debugLabel: 'shellHome');
  static final _shellNavigatorFavourite = GlobalKey<NavigatorState>(debugLabel: 'shellFavourite');

  static final GoRouter router = GoRouter(
    initialLocation: '/',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    routerNeglect: true,
    routes: [
      // MainWrapper
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainWrapper(navigationShell: navigationShell);
        },
        branches: <StatefulShellBranch>[
          /// Brach Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHome,
            routes: <RouteBase>[
              GoRoute(
                name: 'home',
                path: '/',
                builder: (context, state) {
                  return HomePage(key: state.pageKey);
                },
              ),              
            ]
          ),

          /// Brach Favourite
          StatefulShellBranch(
            navigatorKey: _shellNavigatorFavourite,
            routes: <RouteBase>[
              GoRoute(
                name: 'favourite',
                path: '/favourite',
                builder: (context, state) {
                  return FavouritePage(key: state.pageKey);
                },
              ),              
            ]
          ),
        ]
      ),

      GoRoute(
        name: 'book',
        path: '/book',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (BuildContext context, GoRouterState state) {
          return const DetailBookPage();
        },
      ),

    ]
  );
  
}