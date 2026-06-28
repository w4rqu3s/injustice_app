import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:injustice_app/data/services/character_remote_storage_interface.dart';
import '../../core/failure/failure.dart';
import '../../core/typedefs/types_defs.dart';
import '../../domain/models/character_entity.dart';
import '../../domain/models/character_mapper.dart';
import '../../../core/patterns/result.dart';

final class CharacterFirestoreService implements ICharacterRemoteStorage {
  // Instância do Firestore
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Nome da coleção no Firestore
  static const String _collectionKey = 'characters';

  // Atalho para acessar a coleção de personagens
  CollectionReference<Map<String, dynamic>> get _collection =>
      _firestore.collection(_collectionKey);

  @override
  Future<ListCharacterResult> getAllCharacters() async {
    try {
      // Busca todos os documentos da coleção
      final querySnapshot = await _collection.get();

      if (querySnapshot.docs.isEmpty) {
        return Error(EmptyResultFailure());
      }

      // Mapeia os documentos convertendo cada um para a entidade Character
      final characters = querySnapshot.docs.map((doc) {
        // Passa os dados do documento (Firebase já entrega como Map)
        return CharacterMapper.fromMap(doc.data());
      }).toList();

      return Success(characters);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao obter personagens: $e'),
      );
    }
  }

  @override
  Future<CharacterResult> getCharacterById(String id) async {
    try {
      // Busca o documento específico pelo ID
      final docSnapshot = await _collection.doc(id).get();

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        return Error(ApiLocalFailure('Personagem não encontrado'));
      }

      final character = CharacterMapper.fromMap(docSnapshot.data()!);
      return Success(character);
    } catch (e) {
      return Error(ApiLocalFailure('Firestore - Erro ao buscar personagem: $e'));
    }
  }

  @override
  Future<CharacterResult> saveCharacter(Character character) async {
    try {
      // Converte a entidade para Map usando o seu Mapper
      final characterMap = CharacterMapper.toMap(character);

      // Salva usando o id do próprio objeto como a chave do documento no Firestore
      await _collection.doc(character.id).set(characterMap);

      return Success(character);
    } catch (e) {
      return Error(
        ApiLocalFailure('Firestore - Erro ao salvar personagem: $e'),
      );
    }
  }

  @override
  Future<CharacterResult> editCharacter(Character character) async {
    try {
      // Verifica primeiro se o documento existe para manter o comportamento da sua regra de negócio
      final docRef = _collection.doc(character.id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists) {
        return Error(ApiLocalFailure('Personagem não encontrado'));
      }

      final characterMap = CharacterMapper.toMap(character);
      
      // Atualiza o documento no Firestore
      await docRef.update(characterMap);

      return Success(character);
    } catch (e) {
      return Error(ApiLocalFailure('Firestore - Erro ao editar personagem: $e'));
    }
  }

  @override
  Future<CharacterResult> deleteCharacter(String id) async {
    try {
      final docRef = _collection.doc(id);
      final docSnapshot = await docRef.get();

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        return Error(ApiLocalFailure('Personagem não encontrado para deleção'));
      }

      final character = CharacterMapper.fromMap(docSnapshot.data()!);

      // Deleta o documento do Firestore
      await docRef.delete();

      return Success(character);
    } catch (e) {
      return Error(ApiLocalFailure('Firestore - Erro ao deletar personagem: $e'));
    }
  }
}