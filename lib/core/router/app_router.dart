import 'package:flutter/material.dart';

import 'package:go_router/go_router.dart';
import 'package:challenge/features/event/view/meetup_page.dart';
import 'package:challenge/features/bookmark_list/view/bookmark_list_page.dart';

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
            _ScaffoldWithNestedNavigation(navigationShell: child),
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
