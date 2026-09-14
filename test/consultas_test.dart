import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:marcacao_consultas_flutter/main.dart';
import 'package:marcacao_consultas_flutter/src/components/consulta_card.dart';
import 'package:marcacao_consultas_flutter/src/data/data.dart';
import 'package:marcacao_consultas_flutter/src/models/models.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('JSON preserva os models, data, status e campos opcionais', () {
    for (final status in StatusConsulta.values) {
      final consulta = criarConsultasMock().first.copyWith(status: status);
      final json =
          jsonDecode(jsonEncode(consulta.toJson())) as Map<String, dynamic>;
      final restaurada = Consulta.fromJson(json);
      expect(restaurada.toJson(), consulta.toJson());
      expect(restaurada.data, consulta.data);
    }

    final json = criarConsultasMock().first.toJson();
    json['valor'] = 350;
    json['observacoes'] = null;
    (json['paciente'] as Map<String, dynamic>)['telefone'] = null;
    final consulta = Consulta.fromJson(json);
    expect(consulta.valor, 350.0);
    expect(consulta.observacoes, isNull);
    expect(consulta.paciente.telefone, isNull);
  });

  test('primeiro carregamento cria e grava as três consultas', () async {
    final consultas = await ConsultaStorage.carregar();
    expect(consultas.map((c) => c.paciente.nome), [
      'Carlos Andrade',
      'Ana Souza',
      'João Pereira',
    ]);
    expect(consultas.map((c) => c.status), [
      StatusConsulta.agendada,
      StatusConsulta.agendada,
      StatusConsulta.confirmada,
    ]);
    final prefs = await SharedPreferences.getInstance();
    expect(
      jsonDecode(prefs.getString('consultas')!),
      consultas.map((c) => c.toJson()).toList(),
    );
  });

  test('carrega o JSON existente sem substituir pelo mock', () async {
    final consultas = criarConsultasMock();
    final salvas = [
      consultas[1].copyWith(status: StatusConsulta.cancelada),
      consultas[0].copyWith(status: StatusConsulta.confirmada),
    ];
    SharedPreferences.setMockInitialValues({
      'consultas': jsonEncode(salvas.map((c) => c.toJson()).toList()),
    });
    final carregadas = await ConsultaStorage.carregar();
    expect(
      carregadas.map((c) => c.toJson()).toList(),
      salvas.map((c) => c.toJson()).toList(),
    );

    await ConsultaStorage.salvar([]);
    expect(await ConsultaStorage.carregar(), isEmpty);
  });

  testWidgets('ações pelo id persistem e detalhes permitem abrir e voltar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    // A ordem diferente detecta ações que usam a posição em vez do id.
    final mock = criarConsultasMock();
    await ConsultaStorage.salvar([mock[1], mock[2], mock[0]]);
    await tester.pumpWidget(const MarcacaoConsultasApp());
    await tester.pumpAndSettle();
    expect(find.byType(ConsultaCard), findsNWidgets(3));

    Finder card(int id) => find.byKey(ValueKey(id));
    Finder botao(int id, String label) =>
        find.descendant(of: card(id), matching: find.text(label));

    await tester.tap(botao(2, 'Ver Detalhes'));
    await tester.pumpAndSettle();
    expect(find.text('Detalhes da consulta'), findsOneWidget);
    expect(find.text('Ana Souza'), findsOneWidget);
    expect(find.text('Confirmar'), findsNothing);
    expect(find.text('Cancelar'), findsNothing);
    expect(find.text('Ver Detalhes'), findsNothing);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(botao(1, 'Confirmar'));
    await tester.pumpAndSettle();
    expect(botao(1, 'CONFIRMADA'), findsOneWidget);
    expect(botao(2, 'AGENDADA'), findsOneWidget);
    await tester.tap(botao(2, 'Cancelar'));
    await tester.pumpAndSettle();
    expect(botao(2, 'CANCELADA'), findsOneWidget);
    expect(botao(3, 'CONFIRMADA'), findsOneWidget);

    final prefs = await SharedPreferences.getInstance();
    final jsonSalvo = prefs.getString('consultas')!;
    await tester.pumpWidget(const SizedBox.shrink());
    SharedPreferences.setMockInitialValues({'consultas': jsonSalvo});
    await tester.pumpWidget(const MarcacaoConsultasApp());
    await tester.pumpAndSettle();
    expect(botao(1, 'CONFIRMADA'), findsOneWidget);
    expect(botao(2, 'CANCELADA'), findsOneWidget);
    expect(botao(3, 'CONFIRMADA'), findsOneWidget);
    expect(find.text('Confirmar'), findsNothing);
    expect(find.text('Cancelar'), findsNothing);
    expect(tester.takeException(), isNull);
  });
}
