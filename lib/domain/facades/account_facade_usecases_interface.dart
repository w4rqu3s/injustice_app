import '../../core/typedefs/types_defs.dart';

abstract interface class IAccountFacadeUseCases {
  Future<ListAccountResult> getAllAccounts(AccountUserParams params);
  Future<AccountResult> getAccountById(AccountIdParams params);
  Future<AccountResult> saveAccount(AccountParams params);
  Future<AccountResult> updateAccount(AccountParams params);
  Future<AccountResult> deleteAccount(AccountIdParams params);
}
