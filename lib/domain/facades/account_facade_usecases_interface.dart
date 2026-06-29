import '../../core/typedefs/types_defs.dart';

abstract interface class IAccountFacadeUseCases {
  Future<ListAccountResult> getAllAccounts(AccountUserParams params);
  Future<AccountResult> getAccountById(AccountIdParams params);
  Future<VoidResult> saveAccount(AccountParams params);
  Future<VoidResult> updateAccount(AccountParams params);
  Future<VoidResult> deleteAccount(AccountIdParams params);
}
