import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:injustice_app/core/routes/app_routes.dart';
import 'package:injustice_app/core/theme/app_theme.dart';
import 'package:injustice_app/domain/models/account_entity.dart';
import 'package:injustice_app/presentation/widgets/app_drawer.dart';
import 'package:intl/intl.dart';

class AccountHeader extends StatelessWidget {
  final Account account;

  const AccountHeader({
    super.key,
    required this.account,
  });

  @override
  Widget build(BuildContext context) {
     return Scaffold(
      appBar: AppBar(title: const Text('Inj2 Mobile - Player Acc')),
      // drawer: AppDrawer(),
      body: Center(
        child: _AccountBody(account: account)
        )
     );
  }

  
}

class _AccountBody extends StatelessWidget {

  final Account account;

  const _AccountBody ({required this.account});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: AppSpacing.paddingLg,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _AccountHeaderCard(
            displayName: account.displayName,
            email: account.email,
            level: account.level,
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Recursos',
            style: context.textStyles.titleLarge?.semiBold,
          ),

          const SizedBox(height: AppSpacing.md),

          Row(
            children: [
              Expanded(
                child: _ResourceCard(
                  icon: Icons.diamond,
                  label: 'Gemas',
                  value: account.gems.toString(),
                  color: Colors.cyan,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _ResourceCard(
                  icon: Icons.bolt,
                  label: 'Energia',
                  value: account.energy.toString(),
                  color: Colors.green,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppSpacing.md),

          Center(
            child: FractionallySizedBox(
              widthFactor: .6,
              child: _ResourceCard(
                icon: Icons.monetization_on,
                label: 'Gold',
                value: NumberFormat.currency(
                  locale: 'en_US',
                  symbol: '\$ ',
                  decimalDigits: 2,
                ).format(account.gold),
                color: Colors.amber,
              ),
            ),
          ),

          const SizedBox(height: AppSpacing.lg),

          Text(
            'Informações da Conta',
            style: context.textStyles.titleLarge?.semiBold,
          ),

          const SizedBox(height: AppSpacing.md),

          _InfoCard(
            icon: Icons.calendar_today,
            label: 'Data de Criação',
            value: DateFormat('dd/MM/yyyy').format(account.createdAt),
          ),

          const SizedBox(height: AppSpacing.xl),

           Center(
              child: FilledButton.icon(
                onPressed: () => context.pushNamed(AppRouteNames.characters, extra: account),
                // onPressed: () => context.push(AppRoutes.personagens),
                icon: const Icon(Icons.people),
                label: const Text('Ver Meus Personagens'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.xl,
                    vertical: AppSpacing.md,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

}

/// Card de cabeçalho com informações básicas da conta
class _AccountHeaderCard extends StatelessWidget {
  final String displayName;
  final String email;
  final int level;

  const _AccountHeaderCard({
    required this.displayName,
    required this.email,
    required this.level,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: AppSpacing.paddingLg,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.9),
            Theme.of(context).colorScheme.secondary,
            Theme.of(context).colorScheme.tertiary,
            Theme.of(context).colorScheme.secondary.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Theme.of(context).colorScheme.onSecondary,
                child: Text(
                  displayName[0].toUpperCase(),
                  style: context.textStyles.headlineMedium?.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      displayName,
                      style: context.textStyles.headlineSmall?.copyWith(
                        // color: Theme.of(context).colorScheme.onPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: context.textStyles.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.military_tech,
                  color: Theme.of(context).colorScheme.onSecondary,
                  size: 20,
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  'Level $level',
                  style: context.textStyles.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSecondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Card para exibir recursos (Gold, Gemas, Energia)
class _ResourceCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _ResourceCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingMd,
      decoration: BoxDecoration(
        // color: Theme.of(context).colorScheme.surfaceContainerHighest,
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(AppRadius.md),
        // border: Border.all(color: color.withValues(alpha: 0.3), width: 2),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: AppSpacing.sm),
          Text(
            label,
            style: context.textStyles.bodySmall?.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: context.textStyles.titleLarge?.bold.withColor(color),
          ),
        ],
      ),
    );
  }
}

/// Card para informações adicionais
class _InfoCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacing.paddingMd,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.secondary,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: Theme.of(context).colorScheme.outline.withValues(alpha: 0.2),
        ),
      ),
      child: Row(
        children: [
          Icon(icon, color: Theme.of(context).colorScheme.primary, size: 24),
          const SizedBox(width: AppSpacing.md),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: context.textStyles.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(value, style: context.textStyles.titleMedium?.semiBold),
            ],
          ),
        ],
      ),
    );
  }
}

/// Seção de informação reutilizável
