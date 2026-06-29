import 'package:injustice_app/domain/models/account_entity.dart';

import 'package:signals_flutter/signals_flutter.dart';


class AccountsStateViewModel {
  /// Estado da Lista de Personagens, inicializada como nula
  final state = Signal<List<Account>>([]);

  /// Mensagem de erro ou aviso, inicializada como nula
  final message = signal<String?>(null);
  
  /// Limpa qualquer mensagem de erro ou aviso
  void clearMessage() => message.value = null;

  /// Define uma mensagem de erro ou aviso
  void setMessage(String msg) => message.value = msg;
}
