import '../../core/typedefs/types_defs.dart';
import '../../data/repositories/account_repository_interface.dart';
import 'account_usecases_interfaces.dart';

/// implementacao de todos os usecases relacionados a Account

/// usecase para obter todas as contas de um usuário
final class GetAllAccountsUseCaseImpl implements IGetAllAccountsUseCase {
  final IAccountRepository _repository;

  GetAllAccountsUseCaseImpl({required IAccountRepository repository})
    : _repository = repository;

  @override
  Future<ListAccountResult> call(AccountUserParams params) async {
    return _repository.getAllAccounts(params.userId);
  }
}

/// usecase para obter a conta por um id selecionado
final class GetAccountByIdUseCaseImpl implements IGetAccountByIdUseCase {
  final IAccountRepository _repository;

  GetAccountByIdUseCaseImpl({required IAccountRepository repository})
    : _repository = repository;

  @override
  Future<AccountResult> call(AccountIdParams params) async {
    return _repository.getAccountById(params.id);
  }
}

/// usecase para salvar a conta do usuario
final class SaveAccountUseCaseImpl implements ISaveAccountUseCase {
  final IAccountRepository _repository;

  SaveAccountUseCaseImpl({required IAccountRepository repository})
    : _repository = repository;

  @override
  Future<AccountResult> call(AccountParams params) async {
    await Future.delayed(
      const Duration(seconds: 3),
    ); // Simula um atraso para teste de loading
    return _repository.saveAccount(params.account);
  }
}

/// usecase para deletar a conta do usuario
final class DeleteAccountUseCaseImpl implements IDeleteAccountUseCase {
  final IAccountRepository _repository;

  DeleteAccountUseCaseImpl({required IAccountRepository repository})
    : _repository = repository;

  @override
  Future<AccountResult> call(AccountIdParams params) async {
    await Future.delayed(const Duration(seconds: 3)); // Simul  a um atraso para teste de loading
    return _repository.deleteAccount(params.id);
  }
}

final class UpdateAccountUseCaseImpl implements IUpdateAccountUseCase {
  final IAccountRepository _repository;

  UpdateAccountUseCaseImpl({required IAccountRepository repository})
    : _repository = repository;

  @override
  Future<AccountResult> call(AccountParams params) async {
    await Future.delayed(
      const Duration(seconds: 3),
    ); // Simula um atraso para teste de loading
    return _repository.updateAccount(params.account);
  }
}
