import '../../core/failure/failure.dart';
import '../../core/patterns/command.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/types_defs.dart';
import '../../domain/facades/account_facade_usecases_interface.dart';
import '../../domain/models/account_entity.dart';

final class SaveAccountCommand
    extends ParameterizedCommand<Account, Failure, AccountParams> {
  final IAccountFacadeUseCases _accountFacadeUseCases;

  SaveAccountCommand(this._accountFacadeUseCases);

  @override
  Future<AccountResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Parametro nulo para criar conta.'));
    }
    return await _accountFacadeUseCases.saveAccount(parameter!);
  }
}

final class UpdateAccountCommand
    extends ParameterizedCommand<Account, Failure, AccountParams> {
  final IAccountFacadeUseCases _accountFacadeUseCases;

  UpdateAccountCommand(this._accountFacadeUseCases);

  @override
  Future<AccountResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Parametro nulo para atualizar conta.'));
    }
    return await _accountFacadeUseCases.updateAccount(parameter!);
  }
}

final class GetAllAccountsCommand
    extends ParameterizedCommand<List<Account>, Failure, AccountUserParams> {
  final IAccountFacadeUseCases _accountFacadeUseCases;

  GetAllAccountsCommand(this._accountFacadeUseCases);

  @override
  Future<ListAccountResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Parametro nulo para buscar todas as contas.'));
    }
    return await _accountFacadeUseCases.getAllAccounts((parameter!));
  }
}

final class GetAccountByIdCommand
    extends ParameterizedCommand<Account, Failure, AccountIdParams> {
  final IAccountFacadeUseCases _accountFacadeUseCases;

  GetAccountByIdCommand(this._accountFacadeUseCases);

  @override
  Future<AccountResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Parametro nulo para buscar conta.'));
    }
    return await _accountFacadeUseCases.getAccountById((parameter!));
  }
}

final class DeleteAccountCommand
    extends ParameterizedCommand<Account, Failure, AccountIdParams> {
  final IAccountFacadeUseCases _accountFacadeUseCases;

  DeleteAccountCommand(this._accountFacadeUseCases);

  @override
  Future<AccountResult> execute() async {
    if (parameter == null) {
      return Error(InputFailure('Parametro nulo para deletar conta.'));
    }
    return await _accountFacadeUseCases.deleteAccount((parameter!));
  }
}
