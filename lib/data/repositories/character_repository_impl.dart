import '../../core/typedefs/types_defs.dart';
import 'character_repository_interface.dart';
import '../services/character_remote_storage_interface.dart';
import '../../domain/models/character_entity.dart';

/// implementacao do repositorio de character

final class CharacterRepositoryImpl implements ICharacterRepository {
  final ICharacterRemoteStorage _remoteStorage;

  CharacterRepositoryImpl({required ICharacterRemoteStorage remoteStorage})
    : _remoteStorage = remoteStorage;

  @override
  Future<CharacterResult> deleteCharacter(String id) {
    return _remoteStorage.deleteCharacter(id);
  }

  @override
  Future<CharacterResult> getCharacterById(String id) {
    return _remoteStorage.getCharacterById(id);
  }

  @override
  Future<ListCharacterResult> getAllCharacters() {
    return _remoteStorage.getAllCharacters();
  }

  @override
  Future<CharacterResult> saveCharacter(Character character) {
    return _remoteStorage.saveCharacter(character);
  }

  @override
  Future<CharacterResult> editCharacter(Character character) {
    return _remoteStorage.editCharacter(character);
  }
}
