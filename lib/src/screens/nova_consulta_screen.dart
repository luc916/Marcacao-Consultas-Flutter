import 'package:flutter/material.dart';

import '../data/data.dart';
import '../models/models.dart';
import '../styles/app_colors.dart';

class NovaConsultaScreen extends StatefulWidget {
  const NovaConsultaScreen({super.key, required this.proximoId});

  final int proximoId;

  @override
  State<NovaConsultaScreen> createState() => _NovaConsultaScreenState();
}

class _NovaConsultaScreenState extends State<NovaConsultaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _valorController = TextEditingController();
  final _observacoesController = TextEditingController();

  Paciente? _paciente;
  Medico? _medico;
  late DateTime _data;

  List<Paciente> get _pacientes => const [
    pacienteCarlos,
    pacienteAna,
    pacienteJoao,
  ];

  List<Medico> get _medicos => const [medicoRoberto, medicaMarina];

  @override
  void initState() {
    super.initState();
    final amanha = DateTime.now().add(const Duration(days: 1));
    _data = DateTime(amanha.year, amanha.month, amanha.day, 9);
  }

  @override
  void dispose() {
    _valorController.dispose();
    _observacoesController.dispose();
    super.dispose();
  }

  Future<void> _selecionarData() async {
    final selecionada = await showDatePicker(
      context: context,
      initialDate: _data,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (selecionada == null) return;
    setState(() {
      _data = DateTime(
        selecionada.year,
        selecionada.month,
        selecionada.day,
        _data.hour,
        _data.minute,
      );
    });
  }

  Future<void> _selecionarHorario() async {
    final selecionado = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_data),
    );
    if (selecionado == null) return;
    setState(() {
      _data = DateTime(
        _data.year,
        _data.month,
        _data.day,
        selecionado.hour,
        selecionado.minute,
      );
    });
  }

  double? _converterValor(String texto) {
    return double.tryParse(texto.trim().replaceAll(',', '.'));
  }

  void _salvar() {
    if (!_formKey.currentState!.validate()) return;

    final observacoes = _observacoesController.text.trim();
    final consulta = Consulta(
      id: widget.proximoId,
      medico: _medico!,
      paciente: _paciente!,
      data: _data,
      valor: _converterValor(_valorController.text)!,
      status: StatusConsulta.agendada,
      observacoes: observacoes.isEmpty ? null : observacoes,
    );
    Navigator.of(context).pop(consulta);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaria,
      appBar: AppBar(
        backgroundColor: AppColors.primaria,
        foregroundColor: AppColors.branco,
        title: const Text('Nova consulta'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.branco,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Dados do agendamento',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: AppColors.primaria,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DropdownButtonFormField<Paciente>(
                    key: const Key('paciente-field'),
                    initialValue: _paciente,
                    decoration: const InputDecoration(
                      labelText: 'Paciente',
                      border: OutlineInputBorder(),
                    ),
                    items: _pacientes
                        .map(
                          (paciente) => DropdownMenuItem(
                            value: paciente,
                            child: Text(paciente.nome),
                          ),
                        )
                        .toList(),
                    onChanged: (paciente) => setState(() {
                      _paciente = paciente;
                    }),
                    validator: (paciente) =>
                        paciente == null ? 'Selecione um paciente' : null,
                  ),
                  const SizedBox(height: 16),
                  DropdownButtonFormField<Medico>(
                    key: const Key('medico-field'),
                    initialValue: _medico,
                    decoration: const InputDecoration(
                      labelText: 'Médico',
                      border: OutlineInputBorder(),
                    ),
                    items: _medicos
                        .map(
                          (medico) => DropdownMenuItem(
                            value: medico,
                            child: Text(
                              '${medico.nome} — ${medico.especialidade.nome}',
                            ),
                          ),
                        )
                        .toList(),
                    onChanged: (medico) => setState(() {
                      _medico = medico;
                    }),
                    validator: (medico) =>
                        medico == null ? 'Selecione um médico' : null,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          key: const Key('data-field'),
                          onPressed: _selecionarData,
                          icon: const Icon(Icons.calendar_month),
                          label: Text(_formatarData(_data)),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: OutlinedButton.icon(
                          key: const Key('horario-field'),
                          onPressed: _selecionarHorario,
                          icon: const Icon(Icons.schedule),
                          label: Text(_formatarHorario(_data)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('valor-field'),
                    controller: _valorController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(
                      labelText: 'Valor da consulta',
                      prefixText: 'R\$ ',
                      border: OutlineInputBorder(),
                    ),
                    validator: (texto) {
                      final valor = _converterValor(texto ?? '');
                      return valor == null || valor <= 0
                          ? 'Informe um valor válido'
                          : null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    key: const Key('observacoes-field'),
                    controller: _observacoesController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Observações (opcional)',
                      alignLabelWithHint: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 24),
                  FilledButton.icon(
                    key: const Key('salvar-consulta-button'),
                    onPressed: _salvar,
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.primaria,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    icon: const Icon(Icons.save),
                    label: const Text('Salvar consulta'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

String _formatarData(DateTime data) {
  final dia = data.day.toString().padLeft(2, '0');
  final mes = data.month.toString().padLeft(2, '0');
  return '$dia/$mes/${data.year}';
}

String _formatarHorario(DateTime data) {
  final hora = data.hour.toString().padLeft(2, '0');
  final minuto = data.minute.toString().padLeft(2, '0');
  return '$hora:$minuto';
}
