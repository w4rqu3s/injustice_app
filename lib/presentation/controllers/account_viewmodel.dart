import '../../domain/facades/account_facade_usecases_interface.dart';
import '../commands/account_commands.dart';
import 'account_commands_viewmodel.dart';
import 'account_state_viewmodel.dart';

class AccountViewModel {
  late final AccountsStateViewModel _state;

  /// Getter público para acessar o estado de Account
  AccountsStateViewModel get accountState => _state;

  /// dispara os commands e effects e observa as mudanças de estado
  late final AccountCommandsViewmodel commands;

  /// Construtor que inicializa a VieModel principal
  /// que será consumida na UI
  /// injeta a dependência do Facade dos casos de uso de Account
  /// o facade sera consumiro pelos commands

  AccountViewModel(IAccountFacadeUseCases facade) {
    _state = AccountsStateViewModel();
    // dispara os commands e effects
    commands = AccountCommandsViewmodel(
      state: _state,
      saveAccountCommand: SaveAccountCommand(facade),
      updateAccountCommand: UpdateAccountCommand(facade),
      getAllAccountsCommand: GetAllAccountsCommand(facade),
      deleteAccountCommand: DeleteAccountCommand(facade),
    );
  }
  // --- Comandos expostos ---
  GetAllAccountsCommand get getAllAccountsCommand => 
    commands.getAllAccountsCommand;
  SaveAccountCommand get saveAccountCommand => 
      commands.saveAccountCommand;
  DeleteAccountCommand get deleteAccountCommand =>
      commands.deleteAccountCommand;
  UpdateAccountCommand get updateAccountCommand =>
      commands.updateAccountCommand;
}
