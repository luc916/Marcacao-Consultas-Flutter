import 'package:flutter/material.dart';

import '../components/components.dart';
import '../data/data.dart';
import '../models/models.dart';
import '../styles/app_colors.dart';
import 'detalhe_consulta_screen.dart';
import 'nova_consulta_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Consulta> _consultas = [];
  bool _carregando = true;

  @override
  void initState() {
    super.initState();
    _carregarConsultas();
  }

  Future<void> _carregarConsultas() async {
    final consultas = await ConsultaStorage.carregar();
    if (!mounted) return;
    setState(() {
      _consultas = consultas;
      _carregando = false;
    });
  }

  Future<void> _confirmarConsulta(int id) async {
    await _atualizarStatus(id, StatusConsulta.confirmada);
  }

  Future<void> _cancelarConsulta(int id) async {
    await _atualizarStatus(id, StatusConsulta.cancelada);
  }

  Future<void> _atualizarStatus(int id, StatusConsulta status) async {
    setState(() {
      _consultas = _consultas
          .map(
            (consulta) => consulta.id == id
                ? consulta.copyWith(status: status)
                : consulta,
          )
          .toList();
    });
    await ConsultaStorage.salvar(_consultas);
  }

  Future<void> _abrirNovaConsulta() async {
    final proximoId =
        _consultas.fold<int>(
          0,
          (maiorId, consulta) => consulta.id > maiorId ? consulta.id : maiorId,
        ) +
        1;
    final consulta = await Navigator.of(context).push<Consulta>(
      MaterialPageRoute(
        builder: (_) => NovaConsultaScreen(proximoId: proximoId),
      ),
    );

    if (consulta == null || !mounted) return;

    setState(() {
      _consultas = [..._consultas, consulta];
    });
    await ConsultaStorage.salvar(_consultas);

    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Consulta agendada com sucesso!')),
    );
  }

  Future<void> _excluirConsulta(int id) async {
    setState(() {
      _consultas = _consultas.where((consulta) => consulta.id != id).toList();
    });
    await ConsultaStorage.salvar(_consultas);
  }

  void _abrirDetalhes(int id) {
    final consulta = _consultas.firstWhere((item) => item.id == id);
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => DetalheConsultaScreen(
          consulta: consulta,
          onExcluir: () => _excluirConsulta(id),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaria,
      floatingActionButton: FloatingActionButton.extended(
        key: const Key('nova-consulta-button'),
        onPressed: _abrirNovaConsulta,
        backgroundColor: AppColors.branco,
        foregroundColor: AppColors.primaria,
        icon: const Icon(Icons.add),
        label: const Text('Nova consulta'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Column(
                children: [
                  Text(
                    'Sistema de Consultas',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.branco,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Acompanhe o status da sua consulta',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: AppColors.branco, fontSize: 16),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: _carregando
                  ? const Center(
                      child: CircularProgressIndicator(color: AppColors.branco),
                    )
                  : _consultas.isEmpty
                  ? const Center(
                      child: Text(
                        'Nenhuma consulta agendada.',
                        style: TextStyle(color: AppColors.branco, fontSize: 18),
                      ),
                    )
                  : ListView.separated(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                      itemCount: _consultas.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        final consulta = _consultas[index];
                        return ConsultaCard(
                          key: ValueKey(consulta.id),
                          consulta: consulta,
                          onConfirmar: _confirmarConsulta,
                          onCancelar: _cancelarConsulta,
                          onVerDetalhes: _abrirDetalhes,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
