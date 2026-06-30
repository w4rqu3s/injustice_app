import '../../core/typedefs/types_defs.dart';
import '../../domain/models/character_entity.dart';

abstract interface class ICharacterRemoteStorage {
  Future<CharacterResult> saveCharacter(Character character);
  Future<ListCharacterResult> getAllCharacters(String accountId);
  Future<CharacterResult> getCharacterById(String id);
  Future<CharacterResult> deleteCharacter(String id);
  Future<CharacterResult> editCharacter (Character character);
  Stream<List<Character>> watchCharacters(String accountId);
  Future<VoidResult> deleteAllCharacters(String accountId);
}
