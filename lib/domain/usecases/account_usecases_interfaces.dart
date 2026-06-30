import '../../core/patterns/i_usecases.dart';
import '../../core/typedefs/types_defs.dart';

abstract interface class IGetAllAccountsUseCase
  implements IUseCase<ListAccountResult, NoParams> {}

abstract interface class IGetAccountByIdUseCase
  implements IUseCase<AccountResult, AccountIdParams> {}

abstract interface class ISaveAccountUseCase
  implements IUseCase<AccountResult, AccountParams> {}

abstract interface class IDeleteAccountUseCase
  implements IUseCase<AccountResult, AccountIdParams> {}

abstract interface class IUpdateAccountUseCase
  implements IUseCase<AccountResult, AccountParams> {}
