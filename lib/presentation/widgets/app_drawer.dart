import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/routes/app_routes.dart';

/// Drawer reutilizável para navegação entre páginas
class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.secondary,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(
                  Icons.videogame_asset,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSecondary,
                ),
                const SizedBox(height: 8),
                Text(
                  'Injustice 2 Mobile',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSecondary,
                      ),
                ),
              ],
            ),
          ),

          /// USER
          ListTile(
            leading: Icon(
              Icons.person,
              color: currentRoute == GlobalPaths.underConstruction
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSecondary,
            ),
            title: Text(
              'Usuário',
              style: currentRoute == GlobalPaths.underConstruction
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
            selected: currentRoute == GlobalPaths.underConstruction,
            onTap: () {
              context.pop();

              if (currentRoute != GlobalPaths.underConstruction) {
                context.goNamed(GlobalRouteNames.underConstruction);
              }
            },
          ),

          /// ACCOUNTS
          ListTile(
            leading: Icon(
              Icons.account_circle,
              color: currentRoute == AppPaths.accounts
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSecondary,
            ),
            title: Text(
              'Contas',
              style: currentRoute == AppPaths.accounts
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
            selected: currentRoute == AppPaths.accounts,
            onTap: () {
              context.pop();

              if (currentRoute != AppPaths.accounts) {
                context.goNamed(AppRouteNames.accounts);
              }
            },
          ),

          /// ABOUT
          ListTile(
            leading: Icon(
              Icons.info,
              color: currentRoute == AppPaths.about
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.onSecondary,
            ),
            title: Text(
              'Sobre',
              style: currentRoute == AppPaths.about
                  ? TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    )
                  : null,
            ),
            selected: currentRoute == AppPaths.about,
            onTap: () {
              context.pop();

              if (currentRoute != AppPaths.about) {
                context.goNamed(AppRouteNames.about);
              }
            },
          ),
        ],
      ),
    );
  }
}