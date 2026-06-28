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
  Future<AccountResult> getAccount() {
    return _remoteStorage.getAccount(); 
  }

  @override
  Future<VoidResult> deleteAccount() {
    return _remoteStorage.deleteAccount();
  }

  @override
  Future<VoidResult> saveAccount(Account account) {
    return _remoteStorage.saveAccount(account);
  }
  
  @override
  Future<VoidResult> updateAccount(Account account) {
    return _remoteStorage.updateAccount(account);
  }
}


