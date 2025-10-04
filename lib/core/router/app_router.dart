import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:challenge/meetup/meetup.dart';
import 'package:challenge/bookmark_list/bookmark_list.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellEventNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'event');
final _shellBookmarkNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'bookmark',
);

class AppRouter {
  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: MeetupPage.path,
    redirect: (context, state) {
      if (state.path == '/') {
        return MeetupPage.path;
      }
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) =>
            _ScaffoldWithNestedNavigation(navigationShell: child),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellEventNavigatorKey,
            routes: [
              GoRoute(
                path: MeetupPage.path,
                builder: (context, state) => const MeetupPage(),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) =>
                        MeetupPage(id: state.pathParameters['id']),
                  ),
                ],
              ),
            ],
          ),
          StatefulShellBranch(
            navigatorKey: _shellBookmarkNavigatorKey,
            routes: [
              GoRoute(
                path: BookmarkListPage.path,
                builder: (context, state) => const BookmarkListPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

class _ScaffoldWithNestedNavigation extends StatelessWidget {
  const _ScaffoldWithNestedNavigation({Key? key, required this.navigationShell})
      : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        destinations: const [
          NavigationDestination(label: 'Event', icon: Icon(Icons.event)),
          NavigationDestination(label: 'Bookmarks', icon: Icon(Icons.bookmark)),
        ],
        onDestinationSelected: _goBranch,
      ),
    );
  }
}
