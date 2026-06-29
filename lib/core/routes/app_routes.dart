import 'package:go_router/go_router.dart';
import 'package:injustice_app/core/routes/auth_routes.dart';
import 'package:injustice_app/presentation/views/accounts/account_header.dart';
import 'package:injustice_app/presentation/views/accounts/list_of/accounts_view.dart';
import 'package:injustice_app/presentation/views/under_construction_view.dart';

import '../../domain/models/account_entity.dart';
import '../../presentation/views/about_view.dart';
import '../../presentation/views/characters/list_of/characters_view.dart';
import '../../presentation/views/home_view.dart';

class GlobalRouteNames {
  static const underConstruction = 'under_construction';
}

class GlobalPaths {
  static const underConstruction = '/under-construction';
}

/// Route names for easier referencing
class AppRouteNames {
  static const home = 'home';
  static const about = 'about';
  static const accounts = 'accounts';
  static const characters = 'characters';
}

/// Paths to keep URL structure consistent
class AppPaths {
  static const home = '/home';
  static const about = '/about';
  static const accounts = '/accounts';
  static const characters = '/characters';
}

/// app routers using go_router
class AppRouter {
  AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AuthPaths.splash,
    routes: <RouteBase>[
      ...authRoutes,
      GoRoute(
        path: GlobalPaths.underConstruction,
        name: GlobalRouteNames.underConstruction,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: UnderConstructionView()),
      ),
      GoRoute(
        path: '/account',
        name: 'account',
        pageBuilder: (context, state) {
          final account = state.extra as Account;
          return NoTransitionPage(
            child: AccountHeader(account: account),
          );
        },
      ),
      GoRoute(
        path: AppPaths.home,
        name: AppRouteNames.home,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: HomeView()),
      ),
      GoRoute(
        path: AppPaths.characters,
        name: AppRouteNames.characters,
        pageBuilder: (context, state) {
          final account = state.extra as Account;
          return NoTransitionPage(child: CharactersView(account: account));
        },
      ),
      GoRoute(
        path: AppPaths.accounts,
        name: AppRouteNames.accounts,
        pageBuilder: (context, state) {
          return NoTransitionPage(child: AccountsView());
        },
      ),
      GoRoute(
        path: AppPaths.about,
        name: AppRouteNames.about,
        pageBuilder: (context, state) =>
            const NoTransitionPage(child: AboutView()),
      ),
    ],
  );
}
