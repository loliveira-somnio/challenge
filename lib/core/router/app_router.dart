import 'package:go_router/go_router.dart';
import 'package:challenge/features/event/presentation/pages/meetup/meetup_page.dart';

class AppRouter {
  static String meetup({String? id}) {
    return id != null ? '/$id' : '/';
  }

  static final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
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
  );
}
