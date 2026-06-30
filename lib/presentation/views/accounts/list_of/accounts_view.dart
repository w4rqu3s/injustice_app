import 'package:flutter/material.dart';
import 'package:injustice_app/presentation/controllers/account_viewmodel.dart';
import 'package:injustice_app/presentation/views/accounts/list_of/widgets/accounts_app_bar.dart';
import 'package:injustice_app/presentation/views/accounts/list_of/widgets/accounts_body.dart';
import 'package:injustice_app/presentation/views/accounts/list_of/widgets/accounts_floating_button.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../widgets/app_drawer.dart';

/// Página de listagem de personagens
class AccountsView extends StatefulWidget {

  const AccountsView({super.key});

  @override
  State<AccountsView> createState() => _AccountsViewState();
}

class _AccountsViewState extends State<AccountsView> {
  late final AccountViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = injector.get<AccountViewModel>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _viewModel.commands.getAllAccounts();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // _viewModel.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AccountsAppBar(),

      drawer: AppDrawer(),
      body: AccountsBody(viewModel: _viewModel),
      floatingActionButton: AccountsFloatingButton(viewModel: _viewModel),
    );
  }
}

