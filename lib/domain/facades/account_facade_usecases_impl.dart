import '../../core/typedefs/types_defs.dart';
import 'account_facade_usecases_interface.dart';
import '../usecases/account_usecases_interfaces.dart';

/// implemantação do [IAccountFacadeUseCases] para
/// chamar os usecases relacionados a Account

final class AccountFacadeUsecasesImpl implements IAccountFacadeUseCases {
  final IGetAllAccountsUseCase _getAllAccountsUseCase;
  final IGetAccountByIdUseCase _getAccountByIdUseCase;
  final ISaveAccountUseCase _saveAccountUseCase;
  final IUpdateAccountUseCase _updateAccountUseCase;
  final IDeleteAccountUseCase _deleteAccountUseCase;

  AccountFacadeUsecasesImpl({
    required IGetAllAccountsUseCase getAllAccountsUseCase,
    required IGetAccountByIdUseCase getAccountByIdUseCase,
    required ISaveAccountUseCase saveAccountUseCase,
    required IUpdateAccountUseCase updateAccountUseCase,
    required IDeleteAccountUseCase deleteAccountUseCase,
  }) : _getAllAccountsUseCase = getAllAccountsUseCase,
       _getAccountByIdUseCase = getAccountByIdUseCase,
       _saveAccountUseCase = saveAccountUseCase,
       _updateAccountUseCase = updateAccountUseCase,
       _deleteAccountUseCase = deleteAccountUseCase;

  @override
  Future<ListAccountResult> getAllAccounts(NoParams params) {
    return _getAllAccountsUseCase(params);
  }

  @override
  Future<AccountResult> getAccountById(AccountIdParams params) {
    return _getAccountByIdUseCase(params);
  }

  @override
  Future<AccountResult> saveAccount(AccountParams params) {
    return _saveAccountUseCase(params);
  }

  @override
  Future<AccountResult> deleteAccount(AccountIdParams params) {
    return _deleteAccountUseCase(params);
  }

  @override
  Future<AccountResult> updateAccount(AccountParams params) {
    return _updateAccountUseCase(params);
  }
}
