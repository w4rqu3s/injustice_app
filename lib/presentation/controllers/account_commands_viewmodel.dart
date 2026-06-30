import '../../core/failure/failure.dart';
import '../../core/patterns/command.dart';
import '../../domain/models/account_entity.dart';
import '../commands/account_commands.dart';
import 'account_state_viewmodel.dart';
import 'package:signals_flutter/signals_flutter.dart';

class AccountCommandsViewmodel {
  final AccountsStateViewModel state;
  final GetAllAccountsCommand _getAllAccountsCommand;
  final SaveAccountCommand _saveAccountCommand;
  final UpdateAccountCommand _updateAccountCommand;
  final DeleteAccountCommand _deleteAccountCommand;

  AccountCommandsViewmodel({
    required this.state,
    required GetAllAccountsCommand getAllAccountsCommand,
    required SaveAccountCommand saveAccountCommand,
    required UpdateAccountCommand updateAccountCommand,
    required DeleteAccountCommand deleteAccountCommand,
  }) : _getAllAccountsCommand = getAllAccountsCommand,
       _saveAccountCommand = saveAccountCommand,
       _updateAccountCommand = updateAccountCommand,
       _deleteAccountCommand = deleteAccountCommand {
    // Observers para cada comando
    _observeGetAllAccounts();
    _observeDeleteAccount();
    _observeSaveAccount();
    _observeUpdateAccount();
  }

  // ========================================================
  //   GETTERS PARA WIDGETS USAREM DIRETAMENTE OS COMANDOS
  // ========================================================
  GetAllAccountsCommand get getAllAccountsCommand => _getAllAccountsCommand;
  SaveAccountCommand get saveAccountCommand => _saveAccountCommand;
  UpdateAccountCommand get updateAccountCommand => _updateAccountCommand;
  DeleteAccountCommand get deleteAccountCommand => _deleteAccountCommand;

  // ========================================================
  //   MÉTODO GENÉRICO DE OBSERVAÇÃO DE COMANDOS
  // ========================================================
  void _observeCommand<T>(
    Command<T, Failure> command, {
    required void Function(T data) onSuccess,
    void Function(Failure err)? onFailure,
  }) {
    effect(() {
      // 1) Ignora enquanto está executando
      if (command.isExecuting.value) return;

      // 2) Ignora até existir um resultado
      final result = command.result.value;
      if (result == null) return;

      // 3) Sucesso ou falha
      result.fold(
        onSuccess: (data) {
          state.clearMessage(); // sempre limpa erros em sucesso
          onSuccess(data); // ação específica para esse comando
          command.clear(); // Limpa o resultado para evitar reprocessamento
        },
        onFailure: (err) {
          state.setMessage(err.msg); // registra o erro no estado
          if (onFailure != null) onFailure(err);
          command.clear(); // Limpa o resultado para evitar reprocessamento
        },
      );
    });
  }

  // ========================================================
  //   OBSERVERS ESPECÍFICOS
  // ========================================================

  /// Buscar todos os personagens
  void _observeGetAllAccounts() {
    _observeCommand<List<Account>>(
      _getAllAccountsCommand,
      onSuccess: (accounts) {
        state.clearMessage(); // Limpa mensagens anteriores
        state.state.value = accounts;
      },
      onFailure: (err) {
          state.setMessage(err.msg);  // registra o erro no estado
          state.state.value = [];
       } 
          
    );
  }

  /// Criar um novo personagem
  void _observeSaveAccount() {
    _observeCommand<Account>(
      _saveAccountCommand,
      onSuccess: (newAccount) {
        final currentList = state.state.value;
        final newlist = [
          ...currentList,
          newAccount,
        ]; // Adiciona o novo personagem à lista
        state.state.value = newlist;
      },
      onFailure: (err) =>
          state.setMessage(err.msg), // registra o erro no estado
    );
  }

  /// Deletar um personagem
  void _observeDeleteAccount() {
    _observeCommand<Account>(
      _deleteAccountCommand,
      onSuccess: (deletedAccount) {
        final newList = state.state.value
            .where((c) => c.id != deletedAccount.id)
            .toList();

        state.state.value = newList;
      },
      onFailure: (err) => state.setMessage(err.msg),
    );
  }

  void _observeUpdateAccount() {
  _observeCommand<Account>(
    _updateAccountCommand,
    onSuccess: (updatedAccount) {
      final list =
          List<Account>.from(
            state.state.value,
          );

      final index = list.indexWhere(
        (c) => c.id == updatedAccount.id,
      );

      if (index != -1) {
        list[index] = updatedAccount;
      }

      state.state.value = list;
    },
  );
}

  // ========================================================
  //   MÉTODOS PÚBLICOS (CHAMADOS PELOS WIDGETS)
  //   que disparam os commands
  // ========================================================
  Future<void> getAllAccounts() async {
    state.clearMessage(); // Limpa mensagens anteriores
    state.state.value = [];
    await _getAllAccountsCommand.executeWith(());
  }

  Future<void> deleteAccount(String id) async {
    state.clearMessage(); // Limpa mensagens anteriores
    await _deleteAccountCommand.executeWith((id: id));
  }

  Future<void> saveAccount(Account account) async {
    state.clearMessage(); // Atualiza o estado
    await _saveAccountCommand.executeWith((account: account));
  }

  Future<void> updateAccount(Account account) async {
    state.clearMessage(); // Atualiza o estado
    await _updateAccountCommand.executeWith((account: account));
  }
}
