import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/failure/failure.dart';
import '../../core/patterns/result.dart';
import '../../core/typedefs/types_defs.dart';
import '../../domain/models/account_entity.dart';
import '../../domain/models/account_mapper.dart';
import 'account_remote_storage_interface.dart'; // Mantive o nome da sua interface

final class AccountFirestoreService implements IAccountRemoteStorage {
  // Instância do Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Nome da coleção no Firestore
  static const String _collectionKey = 'accounts';

  // Atalho para a coleção de contas
  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(_collectionKey);

  @override
  Future<VoidResult> saveAccount(Account account) async {
    try {
      final accountMap = AccountMapper.toMap(account);

      // Salva os dados utilizando o id da própria conta como identificador do documento
      await _collection.doc(account.id).set(accountMap);
      
      return Success(null);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao salvar conta: $e'),
      );
    }
  }

  @override
  Future<AccountResult> getAccount() async {
    try {
      
      // Exemplo buscando a primeira conta encontrada (para manter compatibilidade se houver apenas uma):
      final querySnapshot = await _collection.limit(1).get();

      if (querySnapshot.docs.isEmpty) {
        return Error(EmptyResultFailure());
      }

      final docSnapshot = querySnapshot.docs.first;
      final account = AccountMapper.fromMap(docSnapshot.data());
      
      return Success(account);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao obter conta: $e'),
      );
    }
  }

  @override
  Future<VoidResult> updateAccount(Account account) async {
    try {
      final accountMap = AccountMapper.toMap(account);

      await _collection.doc(account.id).update(accountMap);
      
      return Success(null);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao atualizar conta: $e'),
      );
    }
  }

  @override
  Future<VoidResult> deleteAccount() async {
    try {
      final querySnapshot = await _collection.limit(1).get();

      if (querySnapshot.docs.isNotEmpty) {
        final docId = querySnapshot.docs.first.id;
        await _collection.doc(docId).delete();
      }

      return Success(null);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao deletar conta: $e'),
      );
    }
  }
}
