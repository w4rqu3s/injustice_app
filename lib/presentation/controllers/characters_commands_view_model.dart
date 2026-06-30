import 'package:injustice_app/presentation/commands/character_commands.dart';

import '../../core/failure/failure.dart';
import '../../core/patterns/command.dart';
import '../../domain/models/character_entity.dart';
import 'characters_state_viewmodel.dart';
import 'package:signals_flutter/signals_flutter.dart';

import 'dart:async';

import '../../domain/facades/character_facade_usecases_interface.dart';

class CharactersCommandsViewModel {
  final CharactersStateViewmodel state;
  // final GetAllCharactersCommand _getAllCharactersCommand;
  final CreateCharacterCommand _createCharacterCommand;
  final DeleteCharacterCommand _deleteCharacterCommand;
  final EditCharacterCommand _editCharacterCommand;

  final ICharacterFacadeUseCases _facade;
  StreamSubscription<List<Character>>? _subscription;

  CharactersCommandsViewModel({
    required this.state,
    required ICharacterFacadeUseCases facade,
    required GetAllCharactersCommand getAllCharactersCommand,
    required CreateCharacterCommand createCharacterCommand,
    required DeleteCharacterCommand deleteCharacterCommand,
    required EditCharacterCommand editCharacterCommand,
  }) : _facade = facade,
       //  _getAllCharactersCommand = getAllCharactersCommand,
       _createCharacterCommand = createCharacterCommand,
       _deleteCharacterCommand = deleteCharacterCommand,
       _editCharacterCommand = editCharacterCommand {
    // Observers para cada comando
    // _observeGetAllCharacters();
    _observeCreateCharacter();
    _observeDeleteCharacter();
    _observeEditCharacter();
  }

  // ========================================================
  //   GETTERS PARA WIDGETS USAREM DIRETAMENTE OS COMANDOS
  // ========================================================
  // GetAllCharactersCommand get getAllCharactersCommand => _getAllCharactersCommand;
  CreateCharacterCommand get createCharacterCommand => _createCharacterCommand;
  DeleteCharacterCommand get deleteCharacterCommand => _deleteCharacterCommand;
  EditCharacterCommand get editCharacterCommand => _editCharacterCommand;

  // ========================================================
  //   MÉTODO GENÉRICO DE OBSERVAÇÃO DE COMANDOS
  // ========================================================
  void _observeCommand<T>(
    Command<T, Failure> command, {
    required void Function(T data) onSuccess,
    void Function(Failure err)? onFailure,
  }) {
    effect(() {
      // 1) Ignora enquanto está executando
      if (command.isExecuting.value) return;

      // 2) Ignora até existir um resultado
      final result = command.result.value;
      if (result == null) return;

      // 3) Sucesso ou falha
      result.fold(
        onSuccess: (data) {
          state.clearMessage(); // sempre limpa erros em sucesso
          onSuccess(data); // ação específica para esse comando
          command.clear();
        },
        onFailure: (err) {
          state.setMessage(err.msg); // registra o erro no estado
          if (onFailure != null) onFailure(err);
          command.clear();
        },
      );
    });
  }

  // ========================================================
  //   OBSERVERS ESPECÍFICOS
  // ========================================================

  /// Buscar todos os personagens
  // void _observeGetAllCharacters() {
  //   _observeCommand<List<Character>>(
  //     _getAllCharactersCommand,
  //     onSuccess: (characters) {
  //       state.clearMessage(); // Limpa mensagens anteriores
  //       state.state.value = characters;
  //     },
  //     onFailure: (err) {
  //       state.setMessage(err.msg); // registra o erro no estado
  //       state.state.value = [];
  //     },
  //   );
  // }

  /// Criar um novo personagem
  // void _observeCreateCharacter() {
  //   _observeCommand<Character>(
  //     _createCharacterCommand,
  //     onSuccess: (newCharacter) {
  //       final currentList = state.state.value;
  //       final newlist = [
  //         ...currentList,
  //         newCharacter,
  //       ]; // Adiciona o novo personagem à lista
  //       state.state.value = newlist;
  //     },
  //     onFailure: (err) =>
  //         state.setMessage(err.msg), // registra o erro no estado
  //   );
  // }

  /// Deletar um personagem
  // void _observeDeleteCharacter() {
  //   _observeCommand<Character>(
  //     _deleteCharacterCommand,
  //     onSuccess: (deletedCharacter) {
  //       final newList = state.state.value
  //           .where((c) => c.id != deletedCharacter.id)
  //           .toList();

  //       state.state.value = newList;
  //     },
  //     onFailure: (err) => state.setMessage(err.msg),
  //   );
  // }

  // void _observeEditCharacter() {
  //   _observeCommand<Character>(
  //     _editCharacterCommand,
  //     onSuccess: (updatedCharacter) {
  //       final list = List<Character>.from(state.state.value);

  //       final index = list.indexWhere((c) => c.id == updatedCharacter.id);

  //       if (index != -1) {
  //         list[index] = updatedCharacter;
  //       }

  //       state.state.value = list;
  //     },
  //   );
  // }

  // ========================================================
  //   OBSERVERS NOVOS - STREAM
  // ========================================================

  void _observeCreateCharacter() {
    _observeCommand<Character>(
      _createCharacterCommand,
      onSuccess: (newCharacter) {},
      onFailure: (err) =>
          state.setMessage(err.msg), // registra o erro no estado
    );
  }

  void _observeDeleteCharacter() {
    _observeCommand<Character>(
      _deleteCharacterCommand,
      onSuccess: (deletedCharacter) {},
      onFailure: (err) => state.setMessage(err.msg),
    );
  }

  void _observeEditCharacter() {
    _observeCommand<Character>(
      _editCharacterCommand,
      onSuccess: (updatedCharacter) {},
      onFailure: (err) => state.setMessage(err.msg),
    );
  }

  // ========================================================
  //   MÉTODOS PÚBLICOS (CHAMADOS PELOS WIDGETS)
  //   que disparam os commands
  // ========================================================
  /// buscca personagens e atualiza o estado
  // Future<void> fetchCharacters(String accountId) async {
  //   state.clearMessage(); // Limpa mensagens anteriores
  //   state.state.value = [];
  //   await _getAllCharactersCommand.executeWith((accountId: accountId));
  // }

  void watchCharacters(String accountId) {
    state.clearMessage();
    state.isLoading.value = true;

    _subscription?.cancel();

    _subscription = _facade
        .watchCharacters((accountId: accountId))
        .listen(
          (characters) {
            state.state.value = characters;
            state.clearMessage();
            state.isLoading.value = false;
          },
          onError: (e) {
            state.state.value = [];
            state.setMessage(e.toString());
            state.isLoading.value = false;
          },
        );
  }

  void dispose() {
    _subscription?.cancel();
  }

  /// adiciona personagem e atualiza o estado
  Future<void> addCharacter(Character character) async {
    state.clearMessage(); // Limpa mensagens anteriores
    await _createCharacterCommand.executeWith((character: character));
  }

  /// deleta um personagem e atualiza o estado
  Future<void> deleteCharacter(String id) async {
    state.clearMessage();
    await _deleteCharacterCommand.executeWith((id: id));
  }

  Future<void> editCharacter(Character character) async {
    state.clearMessage();
    await _editCharacterCommand.executeWith((character: character));
  }
}
