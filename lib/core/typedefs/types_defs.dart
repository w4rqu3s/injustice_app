import 'package:flutter/material.dart';
import 'package:injustice_app/authentication/domain/models/auth_entities.dart';
import '../failure/failure.dart';
import '../../domain/models/account_entity.dart';
import '../../domain/models/character_entity.dart';

import '../patterns/result.dart';

// typedefs para tipo Result
typedef VoidResult = Result<void, Failure>;
typedef AuthSessionResult = Result<AuthSession, Failure>;
typedef AccountResult = Result<Account, Failure>;
typedef ListAccountResult = Result<List<Account>, Failure>;
typedef CharacterResult = Result<Character,Failure>;
typedef ListCharacterResult = Result<List<Character>, Failure>;

// typedfs para parâmetros
typedef AccountParams = ({Account account});

typedef AccountIdParams = ({String id});
typedef AccountUserParams = ({String userId});

/// tipos usadoos Conta de Usuario
typedef NoParams = ();
typedef AccountNameParams = ({String accountName});
/// tipos usados para Personagem
typedef CharacterIdParams = ({String id});
typedef CharacterParams = ({Character character});
typedef CharacterAccountParams = ({String accountId});

typedef SignInParams = ({String email, String password});
typedef SignUpParams =
    ({String? name,String email, String password});

/// typedefs para ser usados em componentes de UI
typedef FormFieldControl = ({
  GlobalKey<FormFieldState> key,
  FocusNode focus,
  TextEditingController controller,
});
