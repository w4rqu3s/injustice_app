import 'package:injustice_app/authentication/data/repositories/i_auth_repository.dart';
import 'package:injustice_app/core/failure/failure.dart';
import 'package:injustice_app/core/patterns/result.dart';
import 'package:injustice_app/data/repositories/character_repository_interface.dart';
import 'package:injustice_app/domain/models/account_entity.dart';

import '../../core/typedefs/types_defs.dart';
import '../../data/repositories/account_repository_interface.dart';
import 'account_usecases_interfaces.dart';

/// implementacao de todos os usecases relacionados a Account

/// usecase para obter todas as contas de um usuário
final class GetAllAccountsUseCaseImpl implements IGetAllAccountsUseCase {
  final IAccountRepository _repository;
  final IAuthRepository _authRepository;

  GetAllAccountsUseCaseImpl({
    required IAccountRepository repository,
    required IAuthRepository authRepository,
  }) : _authRepository = authRepository,
       _repository = repository;

  @override
  Future<ListAccountResult> call(NoParams params) async {
    return _repository.getAllAccounts(_authRepository.currentSession!.user.id);
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
  final IAuthRepository _authRepository;

  SaveAccountUseCaseImpl({
    required IAccountRepository repository,
    required IAuthRepository authRepository,
  }) : _authRepository = authRepository,
       _repository = repository;

  @override
  Future<AccountResult> call(AccountParams params) async {
    await Future.delayed(
      const Duration(seconds: 3),
    ); // Simula um atraso para teste de loading

    final accountWithId = params.account.copyWith(
      userId: _authRepository.currentSession!.user.id,
    );

    return _repository.saveAccount(accountWithId);
  }
}

/// usecase para deletar a conta do usuario
final class DeleteAccountUseCaseImpl implements IDeleteAccountUseCase {
  final IAccountRepository _repository;
  final ICharacterRepository _characterRepository;

  DeleteAccountUseCaseImpl({
    required IAccountRepository repository,
    required ICharacterRepository characterRepository,
  }) : _characterRepository = characterRepository,
       _repository = repository;

  @override
  Future<AccountResult> call(AccountIdParams params) async {
    await Future.delayed(
      const Duration(seconds: 3),
    ); // Simula um atraso para teste de loading

    final deleteCharacters = await _characterRepository.deleteAllCharacters(
      params.id,
    );

    if (deleteCharacters.isFailure) {
      return Error(ApiLocalFailure('Erro ao deletar personagens.'));
    }

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
