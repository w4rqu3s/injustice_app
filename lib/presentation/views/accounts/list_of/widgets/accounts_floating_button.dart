import 'package:flutter/material.dart';
import 'package:injustice_app/domain/models/account_entity.dart';
import 'package:injustice_app/presentation/controllers/account_viewmodel.dart';
import 'package:injustice_app/presentation/views/accounts/account_form_view.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AccountsFloatingButton extends StatelessWidget {
  final AccountViewModel viewModel;

  const AccountsFloatingButton({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      final isExecuting =
          viewModel.commands.saveAccountCommand.isExecuting.value;

      return FloatingActionButton(
        onPressed: isExecuting
            ? null
            : () async {
                final account = await Navigator.push<Account>(
                  context,
                  MaterialPageRoute(builder: (_) => AccountFormView()),
                );

                if (account == null) return;

                await viewModel.commands.saveAccount(account);
              },
        child: isExecuting
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: Colors.white,
                ),
              )
            : const Icon(Icons.add),
      );
    });
  }
}
