import '../../core/typedefs/types_defs.dart';
import '../../domain/models/character_entity.dart';

abstract interface class ICharacterRepository {
  Future<CharacterResult> getCharacterById(String id);
  Future<ListCharacterResult> getAllCharacters(String accountId);
  Future<CharacterResult> saveCharacter(Character character);
  Future<CharacterResult> deleteCharacter(String id);
  Future<CharacterResult> editCharacter(Character character);
  Stream<List<Character>> watchCharacters(String accountId);
}