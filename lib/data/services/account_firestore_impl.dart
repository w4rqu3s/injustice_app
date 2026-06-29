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
  Future<AccountResult> saveAccount(Account account) async {
    try {
      final accountMap = AccountMapper.toMap(account);

      // Salva os dados utilizando o id da própria conta como identificador do documento
      await _collection.doc(account.id).set(accountMap);
      
      return Success(account);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao salvar conta: $e'),
      );
    }
  }

  @override
  Future<ListAccountResult> getAllAccounts(String userId) async {
      try {
      // final querySnapshot = await _collection.
      //   where('accountId', isEqualTo: userId).get();
      final querySnapshot = await _collection.get();

      if (querySnapshot.docs.isEmpty) {
        return Error(EmptyResultFailure());
      }

      final accounts = querySnapshot.docs.map((doc) {
        return AccountMapper.fromMap(doc.data());
      }).toList();

      return Success(accounts);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao obter contas: $e'),
      );
    }
  }

  @override
  Future<AccountResult> getAccountById(String id) async {
    try {
      
      final querySnapshot = await _collection.where('id', isEqualTo: id).get();

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
  Future<AccountResult> updateAccount(Account account) async {
    try {
      final accountMap = AccountMapper.toMap(account);

      await _collection.doc(account.id).update(accountMap);
      
      return Success(account);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao atualizar conta: $e'),
      );
    }
  }

  @override
  Future<AccountResult> deleteAccount(String id) async {
    try {
      final docRef = _collection.doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        return Error(ApiLocalFailure('Conta não encontrado para deleção'));
      }

      final account = AccountMapper.fromMap(docSnapshot.data()!);

      // Deleta o documento do Firestore
      await docRef.delete();

      return Success(account);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao deletar conta: $e'),
      );
    }
  }
}
