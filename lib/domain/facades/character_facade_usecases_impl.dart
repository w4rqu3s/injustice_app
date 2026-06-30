import 'package:injustice_app/domain/models/character_entity.dart';

import '../../core/typedefs/types_defs.dart';
import '../usecases/character_usecases_interfaces.dart';
import 'character_facade_usecases_interface.dart';

/// implementacao do [ICharacterFacadeUseCases]
/// para chamar os usecases relacionados a Character

final class CharacterFacadeUseCasesImpl implements ICharacterFacadeUseCases {
  final IGetAllCharactersUseCase _getAllCharactersUseCase;
  final IGetCharacterByIdUseCase _getCharacterByIdUseCase;
  final ISaveCharacterUseCase _saveCharacterUseCase;
  final IDeleteCharacterUseCase _deleteCharacterUseCase;
  final IEditCharacterUseCase _editCharacterUseCase;
  final IWatchCharactersUseCase _watchCharactersUseCase;

  CharacterFacadeUseCasesImpl({
    required IGetAllCharactersUseCase getAllCharactersUseCase,
    required IGetCharacterByIdUseCase getCharacterByIdUseCase,
    required ISaveCharacterUseCase saveCharacterUseCase,
    required IDeleteCharacterUseCase deleteCharacterUseCase,
    required IEditCharacterUseCase editCharacterUseCase,
    required IWatchCharactersUseCase watchCharactersUseCase,
  }) : _watchCharactersUseCase = watchCharactersUseCase,
       _getCharacterByIdUseCase = getCharacterByIdUseCase,
       _saveCharacterUseCase = saveCharacterUseCase,
       _deleteCharacterUseCase = deleteCharacterUseCase,
       _getAllCharactersUseCase = getAllCharactersUseCase,
       _editCharacterUseCase = editCharacterUseCase;

  @override
  Future<ListCharacterResult> getAllCharacters(CharacterAccountParams params) {
    return _getAllCharactersUseCase(params);
  }

  @override
  Future<CharacterResult> getCharacterById(CharacterIdParams params) {
    return _getCharacterByIdUseCase(params);
  }

  @override
  Future<CharacterResult> saveCharacter(CharacterParams params) {
    return _saveCharacterUseCase(params);
  }

  @override
  Future<CharacterResult> deleteCharacter(CharacterIdParams params) {
    return _deleteCharacterUseCase(params);
  }

  @override
  Future<CharacterResult> editCharacter(CharacterParams params) {
    return _editCharacterUseCase(params);
  }

  @override
  Stream<List<Character>> watchCharacters(CharacterAccountParams params) {
    return _watchCharactersUseCase(params);
  }
}
