import '../../core/typedefs/types_defs.dart';
import '../../domain/models/account_entity.dart';

abstract interface class IAccountRemoteStorage {
  Future<AccountResult> saveAccount(Account account);
  Future<AccountResult> updateAccount(Account account);
  Future<ListAccountResult> getAllAccounts(String userId);
  Future<AccountResult> getAccountById(String id);
  Future<AccountResult> deleteAccount(String id);
}
