import 'package:flutter/material.dart';
import 'package:injustice_app/presentation/controllers/account_viewmodel.dart';
import 'package:injustice_app/presentation/views/accounts/account_form_view.dart';
import 'package:signals_flutter/signals_flutter.dart';

import '../../../../../core/theme/app_theme.dart';
import '../../../../../domain/models/account_entity.dart';

import '../../../../widgets/empty_state.dart';
import '../../../../widgets/loading_indicator.dart';

class AccountsBody extends StatelessWidget {
  final AccountViewModel viewModel;

  const AccountsBody({
    super.key,
    required this.viewModel,
  });

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final isLoading =
          viewModel.getAllAccountsCommand.isExecuting.value;

      final accounts =
          viewModel.accountState.state.value;

      return RefreshIndicator(
        onRefresh: () async {
          await viewModel.commands.getAllAccounts('1');
        },
        child: CustomScrollView(
          slivers: [
            if (isLoading)
              const SliverFillRemaining(
                hasScrollBody: false,
                child: LoadingIndicator(
                  message: 'Carregando contas...',
                ),
              )
            else if (accounts.isEmpty)
              SliverFillRemaining(
                hasScrollBody: false,
                child: EmptyState(
                  icon: Icons.account_circle_outlined,
                  title: 'Nenhuma conta encontrada',
                  description:
                      'Toque no botão "+" para criar uma conta.',
                ),
              )
            else
              SliverPadding(
                padding: AppSpacing.paddingMd,
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final account = accounts[index];

                      return AccountListItem(
                        account: account,

                        onDelete: () async {
                          await viewModel.commands
                              .deleteAccount(account.id);
                        },

                        onTap: () async {
                          final edited =
                              await Navigator.push<Account>(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  AccountFormView(
                                account: account,
                              ),
                            ),
                          );

                          if (edited == null) return;

                          await viewModel.commands
                              .updateAccount(edited);
                        },
                      );
                    },
                    childCount: accounts.length,
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }
}

class AccountListItem extends StatelessWidget {
  final Account account;

  final VoidCallback onDelete;
  final VoidCallback onTap;

  const AccountListItem({
    super.key,
    required this.account,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(account.id),

      background: Container(
        margin: const EdgeInsets.only(
          bottom: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius:
              BorderRadius.circular(AppRadius.md),
        ),
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(
          left: AppSpacing.lg,
        ),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),

      secondaryBackground: Container(
        margin: const EdgeInsets.only(
          bottom: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius:
              BorderRadius.circular(AppRadius.md),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(
          right: AppSpacing.lg,
        ),
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),

      confirmDismiss: (direction) async {
        if (direction ==
            DismissDirection.startToEnd) {
          onTap();
          return false;
        }

        return await showDialog<bool>(
              context: context,
              builder: (_) => AlertDialog(
                title:
                    const Text('Confirmar exclusão'),
                content: Text(
                  'Deseja excluir "${account.name}"?',
                ),
                actions: [
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(
                            context, false),
                    child:
                        const Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () =>
                        Navigator.pop(
                            context, true),
                    child:
                        const Text('Excluir'),
                  ),
                ],
              ),
            ) ??
            false;
      },

      onDismissed: (_) => onDelete(),

      child: Card(
        color: Theme.of(context)
            .colorScheme
            .secondary
            .withValues(alpha: .9),

        margin: const EdgeInsets.only(
          bottom: AppSpacing.md,
        ),

        child: InkWell(
          onTap: onTap,
          borderRadius:
              BorderRadius.circular(AppRadius.md),
          child: Padding(
            padding: AppSpacing.paddingMd,
            child: Row(
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor:
                      Theme.of(context)
                          .colorScheme
                          .primary,
                  child: const Icon(
                    Icons.person,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(
                  width: AppSpacing.md,
                ),

                Expanded(
                  child: Column(
                    crossAxisAlignment:
                        CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.name,
                        style: context
                            .textStyles
                            .titleMedium
                            ?.semiBold,
                      ),

                      const SizedBox(
                        height: 2,
                      ),

                      Text(
                        account.displayName,
                        style: context
                            .textStyles
                            .bodyMedium,
                      ),

                      const SizedBox(
                        height: AppSpacing.sm,
                      ),

                      Wrap(
                        spacing: 12,
                        runSpacing: 4,
                        children: [
                          _InfoChip(
                            icon: Icons.trending_up,
                            label:
                                "Lv ${account.level}",
                          ),
                          _InfoChip(
                            icon:
                                Icons.monetization_on,
                            label:
                                account.gold.toStringAsFixed(
                                    0),
                          ),
                          _InfoChip(
                            icon:
                                Icons.diamond,
                            label:
                                "${account.gems}",
                          ),
                          _InfoChip(
                            icon:
                                Icons.bolt,
                            label:
                                "${account.energy}",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.chevron_right,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:
          const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surfaceContainerHighest,
        borderRadius:
            BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 15,
          ),
          const SizedBox(width: 4),
          Text(label),
        ],
      ),
    );
  }
}