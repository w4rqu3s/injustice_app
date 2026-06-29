import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:injustice_app/authentication/presentation/controllers/auth_session_viewmodel.dart';
import 'package:injustice_app/core/di/dependency_injection.dart';
import 'package:injustice_app/core/routes/auth_routes.dart';
import 'package:injustice_app/core/theme/app_theme.dart';
import 'package:injustice_app/presentation/widgets/app_drawer.dart';

class UnderConstructionView extends StatelessWidget {
  const UnderConstructionView({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = injector.get<AuthViewModel>();
    final session = authController.session.session.value;

    return Scaffold(
      backgroundColor: context.theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Usuário'),
        centerTitle: true,
      ),
      drawer: AppDrawer(),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 450),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CircleAvatar(
                      radius: 36,
                      backgroundColor: context.colors.primaryContainer,
                      child: Icon(
                        Icons.person,
                        size: 40,
                        color: context.colors.onPrimaryContainer,
                      ),
                    ),

                    const SizedBox(height: 24),

                    Text(
                      'Usuário autenticado',
                      style: context.textStyles.headlineSmall,
                    ),

                    const SizedBox(height: 24),

                    ListTile(
                      leading: const Icon(Icons.email_outlined),
                      title: const Text('E-mail'),
                      subtitle: Text(
                        session?.user.email ?? 'Não informado',
                      ),
                    ),

                    ListTile(
                      leading: const Icon(Icons.badge_outlined),
                      title: const Text('UID'),
                      subtitle: Text(
                        session?.user.id ?? 'Não informado',
                      ),
                    ),

                    const SizedBox(height: 32),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        icon: const Icon(Icons.logout),
                        label: const Text('Sair'),
                        onPressed: () async {
                          await authController.commands.signOut();

                          if (!context.mounted) return;

                          context.goNamed(AuthRouteNames.splash);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}