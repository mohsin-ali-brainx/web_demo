import 'package:go_router/go_router.dart';

import '../../features/app/presentation/pages/admin_page.dart';
import '../../features/app/presentation/pages/dashboard_page.dart';
import '../../features/app/presentation/pages/forbidden_page.dart';
import '../../features/app/presentation/pages/not_found_page.dart';
import '../../features/app/presentation/pages/orders_page.dart';
import '../../features/app/presentation/pages/product_details_page.dart';
import '../../features/app/presentation/pages/products_page.dart';
import '../../features/app/presentation/pages/settings_page.dart';
import '../../features/app/presentation/widgets/app_shell.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';
import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/public/presentation/pages/about_page.dart';
import '../../features/public/presentation/pages/home_page.dart';
import 'go_router_refresh_stream.dart';

GoRouter createRouter({required AuthBloc authBloc}) {
  return GoRouter(
    initialLocation: '/',
    refreshListenable: GoRouterRefreshStream(authBloc.stream),
    redirect: (context, state) {
      final matched = state.matchedLocation;
      final goingToLogin = matched == '/login';
      final goingToApp = matched.startsWith('/app');
      final goingToAdmin = matched.startsWith('/app/admin');

      final authState = authBloc.state;

      if (!authState.isAuthenticated && goingToApp) {
        return Uri(
          path: '/login',
          queryParameters: {'from': state.uri.toString()},
        ).toString();
      }

      if (authState.isAuthenticated && goingToLogin) {
        final from = state.uri.queryParameters['from'];
        if (from != null && from.isNotEmpty) return from;
        return '/app';
      }

      if (authState.isAuthenticated && goingToAdmin && !authState.isAdmin) {
        return '/app/forbidden';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/about',
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(
          from: state.uri.queryParameters['from'],
        ),
      ),
      ShellRoute(
        builder: (context, state, child) => AppShell(
          matchedLocation: state.matchedLocation,
          child: child,
        ),
        routes: [
          GoRoute(
            path: '/app',
            builder: (context, state) => const DashboardPage(),
            routes: [
              GoRoute(
                path: 'orders',
                builder: (context, state) => OrdersPage(
                  status: state.uri.queryParameters['status'],
                ),
              ),
              GoRoute(
                path: 'products',
                builder: (context, state) => ProductsPage(
                  search: state.uri.queryParameters['search'],
                ),
                routes: [
                  GoRoute(
                    path: ':id',
                    builder: (context, state) => ProductDetailsPage(
                      id: state.pathParameters['id']!,
                    ),
                  ),
                ],
              ),
              GoRoute(
                path: 'settings',
                builder: (context, state) => const SettingsPage(),
              ),
              GoRoute(
                path: 'admin',
                builder: (context, state) => const AdminPage(),
              ),
              GoRoute(
                path: 'forbidden',
                builder: (context, state) => const ForbiddenPage(),
              ),
            ],
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => NotFoundPage(location: state.uri.toString()),
  );
}


