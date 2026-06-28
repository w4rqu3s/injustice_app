import '../../core/typedefs/types_defs.dart';
import '../../domain/models/account_entity.dart';

abstract interface class IAccountRemoteStorage {
  Future<VoidResult> saveAccount(Account account);
  Future<VoidResult> updateAccount(Account account);
  Future<AccountResult> getAccount();
  Future<VoidResult> deleteAccount();
}
