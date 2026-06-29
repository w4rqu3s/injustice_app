import 'package:flutter/material.dart';

class AccountsAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const AccountsAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: const Text('Contas'),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
