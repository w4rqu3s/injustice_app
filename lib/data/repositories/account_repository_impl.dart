import 'package:injustice_app/data/services/account_remote_storage_interface.dart';

import '../../core/typedefs/types_defs.dart';
import 'account_repository_interface.dart';
import '../../domain/models/account_entity.dart';

/// implementação do repositório para Account

final class AccountRepositoryImpl implements IAccountRepository {
  final IAccountRemoteStorage _remoteStorage;

  AccountRepositoryImpl({
    required IAccountRemoteStorage remoteStorage,
  }) : _remoteStorage = remoteStorage;

  @override
  Future<ListAccountResult> getAllAccounts(String userId) {
    return _remoteStorage.getAllAccounts(userId); 
  }

  @override
  Future<AccountResult> getAccountById(String id) {
    return _remoteStorage.getAccountById(id); 
  }

  @override
  Future<AccountResult> deleteAccount(String id) {
    return _remoteStorage.deleteAccount(id);
  }

  @override
  Future<AccountResult> saveAccount(Account account) {
    return _remoteStorage.saveAccount(account);
  }
  
  @override
  Future<AccountResult> updateAccount(Account account) {
    return _remoteStorage.updateAccount(account);
  }
}


