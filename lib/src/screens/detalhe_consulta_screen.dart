import 'package:flutter/material.dart';

import '../components/components.dart';
import '../models/models.dart';
import '../styles/app_colors.dart';

class DetalheConsultaScreen extends StatelessWidget {
  const DetalheConsultaScreen({
    super.key,
    required this.consulta,
    this.onExcluir,
  });

  final Consulta consulta;
  final Future<void> Function()? onExcluir;

  Future<void> _confirmarExclusao(BuildContext context) async {
    final confirmou = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Excluir consulta?'),
        content: const Text(
          'Essa ação remove a consulta e não pode ser desfeita.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(false),
            child: const Text('Voltar'),
          ),
          FilledButton(
            key: const Key('confirmar-exclusao-button'),
            onPressed: () => Navigator.of(dialogContext).pop(true),
            style: FilledButton.styleFrom(backgroundColor: AppColors.perigo),
            child: const Text('Excluir'),
          ),
        ],
      ),
    );

    if (confirmou != true || onExcluir == null) return;
    await onExcluir!();
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaria,
      appBar: AppBar(
        backgroundColor: AppColors.primaria,
        foregroundColor: AppColors.branco,
        elevation: 0,
        title: const Text('Detalhes da consulta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ConsultaCard(consulta: consulta),
              if (onExcluir != null) ...[
                const SizedBox(height: 16),
                OutlinedButton.icon(
                  key: const Key('excluir-consulta-button'),
                  onPressed: () => _confirmarExclusao(context),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.branco,
                    side: const BorderSide(color: AppColors.branco),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  icon: const Icon(Icons.delete_outline),
                  label: const Text('Excluir consulta'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
