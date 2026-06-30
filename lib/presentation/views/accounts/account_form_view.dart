import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'package:injustice_app/core/theme/app_theme.dart';
import 'package:injustice_app/domain/models/account_entity.dart';
import 'package:injustice_app/presentation/widgets/input_text_field.dart';
import 'package:injustice_app/presentation/widgets/numeric_spinner.dart';

class AccountFormView extends StatefulWidget {
  final Account? account;

  const AccountFormView({
    super.key,
    this.account,
  });

  bool get isEditing => account != null;

  @override
  State<AccountFormView> createState() => _AccountFormViewState();
}

class _AccountFormViewState extends State<AccountFormView> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _displayNameController;

  int _level = 1;
  double _gold = 0;
  int _gems = 0;
  int _energy = 1;
  
  @override
  void initState() {
    super.initState();

    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _displayNameController = TextEditingController();

    if (widget.account != null) {
      final account = widget.account!;

      _nameController.text = account.name;
      _displayNameController.text = account.displayName;

      _level = account.level;
      _gold = account.gold;
      _gems = account.gems;
      _energy = account.energy;
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _displayNameController.dispose();
    super.dispose();
  }

  void _save() {
    if (!_formKey.currentState!.validate()) return;

    final now = DateTime.now();

    final account =
        widget.account?.copyWith(
          name: _nameController.text.trim(),
          displayName: _displayNameController.text.trim(),
          level: _level,
          gold: _gold,
          gems: _gems,
          energy: _energy,
          updatedAt: now,
        ) ??
        Account(
          id: const Uuid().v4(),
          name: _nameController.text.trim(),
          displayName: _displayNameController.text.trim(),
          createdAt: now,
          updatedAt: now,
          level: _level,
          gold: _gold,
          gems: _gems,
          energy: _energy, userId: '',
        );

    Navigator.pop(context, account);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isEditing ? 'Editar Conta' : 'Criar Conta',
        ),
      ),
      body: SingleChildScrollView(
        padding: AppSpacing.paddingLg,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.person,
                size: 64,
                color: Theme.of(context).colorScheme.primary,
              ),

              const SizedBox(height: AppSpacing.lg),

              InputTextField(
                label: 'Nome',
                controller: _nameController,
                prefixIcon: Icons.person,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe um nome';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.md),

              const SizedBox(height: AppSpacing.md),

              InputTextField(
                label: 'Apelido',
                controller: _displayNameController,
                prefixIcon: Icons.badge,
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Informe um apelido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: AppSpacing.lg),

              NumericSpinner(
                label: 'Nível',
                value: _level,
                minValue: 1,
                maxValue: 80,
                onChanged: (value) {
                  setState(() => _level = value);
                },
              ),

              const SizedBox(height: AppSpacing.md),

              NumericSpinner(
                label: 'Ouro',
                value: _gold.toInt(),
                minValue: 0,
                maxValue: 999999,
                onChanged: (value) {
                  setState(() => _gold = value.toDouble());
                },
              ),

              const SizedBox(height: AppSpacing.md),

              NumericSpinner(
                label: 'Gemas',
                value: _gems,
                minValue: 0,
                maxValue: 999999,
                onChanged: (value) {
                  setState(() => _gems = value);
                },
              ),

              const SizedBox(height: AppSpacing.md),

              NumericSpinner(
                label: 'Energia',
                value: _energy,
                minValue: 1,
                maxValue: 999999,
                onChanged: (value) {
                  setState(() => _energy = value);
                },
              ),

              const SizedBox(height: AppSpacing.xl),

              ElevatedButton(
                onPressed: _save,
                child: Text(
                  widget.isEditing
                      ? 'SALVAR ALTERAÇÕES'
                      : 'CRIAR CONTA',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}