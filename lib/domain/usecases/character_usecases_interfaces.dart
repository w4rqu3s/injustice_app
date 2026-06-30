import 'package:injustice_app/domain/models/character_entity.dart';

import '../../core/patterns/i_usecases.dart';
import '../../core/typedefs/types_defs.dart';

abstract interface class IGetCharacterByIdUseCase
    implements IUseCase<CharacterResult, CharacterIdParams> {}
abstract interface class IGetAllCharactersUseCase
    implements IUseCase<ListCharacterResult, CharacterAccountParams> {}
abstract interface class ISaveCharacterUseCase
    implements IUseCase<CharacterResult, CharacterParams> {}
abstract interface class IDeleteCharacterUseCase
    implements IUseCase<CharacterResult, CharacterIdParams> {}
abstract interface class IEditCharacterUseCase
    implements IUseCase<CharacterResult, CharacterParams> {}
abstract interface class IWatchCharactersUseCase {
  Stream<List<Character>> call(CharacterAccountParams params);
}