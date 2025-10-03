import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:challenge/features/event/presentation/pages/meetup_page.dart';
import 'package:challenge/features/bookmark/presentation/pages/bookmark_list_page.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellEventNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'event');
final _shellBookmarkNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'bookmark',
);

class AppRouter {
  static String meetup({String? id}) {
    return id != null ? '/event/$id' : '/event';
  }

  static String bookmarks() {
    return '/bookmarks';
  }

  static final GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/event',
    redirect: (context, state) {
      if (state.path == '/') {
        return '/event';
      }
      return null;
    },
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, child) =>
            ScaffoldWithNestedNavigation(navigationShell: child),
        branches: [
          StatefulShellBranch(
            navigatorKey: _shellEventNavigatorKey,
            routes: [
              GoRoute(
                path: '/event',
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
                path: '/bookmarks',
                builder: (context, state) => const BookmarkListPage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

// https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/stateful_shell_route.dart
class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({Key? key, required this.navigationShell})
    : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      // A common pattern when using bottom navigation bars is to support
      // navigating to the initial location when tapping the item that is
      // already active. This example demonstrates how to support this behavior,
      // using the initialLocation parameter of goBranch.
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
