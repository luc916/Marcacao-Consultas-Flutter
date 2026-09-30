import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:marcacao_consultas_flutter/main.dart';
import 'package:marcacao_consultas_flutter/src/components/consulta_card.dart';
import 'package:marcacao_consultas_flutter/src/data/storage.dart';
import 'package:marcacao_consultas_flutter/src/models/models.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() => SharedPreferences.setMockInitialValues({}));

  const especialidade = Especialidade(
    id: 1,
    nome: 'Cardiologia',
    descricao: 'Cuidados com o coração',
  );
  const medico = Medico(
    id: 1,
    nome: 'Dr. Roberto',
    crm: 'CRM123',
    especialidade: especialidade,
    ativo: true,
  );
  const paciente = Paciente(
    id: 1,
    nome: 'Carlos',
    cpf: '123.456.789-00',
    email: 'carlos@email.com',
  );

  Consulta criarConsulta() {
    return Consulta(
      id: 1,
      medico: medico,
      paciente: paciente,
      data: DateTime(2026, 9, 30),
      valor: 350,
      status: StatusConsulta.agendada,
    );
  }

  test('models continuam convertendo os dados para JSON', () {
    final consulta = criarConsulta();
    final json = jsonDecode(jsonEncode(consulta.toJson()));
    final restaurada = Consulta.fromJson(json as Map<String, dynamic>);

    expect(restaurada.toJson(), consulta.toJson());
  });

  test('Storage salva e obtém as três listas separadas', () async {
    expect(await Storage.obterEspecialidades(), isEmpty);
    expect(await Storage.obterMedicos(), isEmpty);
    expect(await Storage.obterConsultas(), isEmpty);

    await Storage.salvarEspecialidades([especialidade]);
    await Storage.salvarMedicos([medico]);
    await Storage.salvarConsultas([criarConsulta()]);

    expect((await Storage.obterEspecialidades()).single.nome, 'Cardiologia');
    expect((await Storage.obterMedicos()).single.nome, 'Dr. Roberto');
    expect((await Storage.obterConsultas()).single.paciente.nome, 'Carlos');

    final prefs = await SharedPreferences.getInstance();
    expect(prefs.containsKey('@consultas:especialidades'), isTrue);
    expect(prefs.containsKey('@consultas:medicos'), isTrue);
    expect(prefs.containsKey('@consultas:consultas'), isTrue);
  });

  testWidgets('Admin cria os dados e a Home recarrega ao voltar', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 2400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(const MarcacaoConsultasApp());
    await tester.pumpAndSettle();

    expect(find.text('Nenhuma consulta agendada ainda'), findsOneWidget);
    await tester.tap(find.text('Ir para Admin'));
    await tester.pumpAndSettle();
    expect(find.text('Painel Administrativo'), findsOneWidget);

    final campos = find.byType(TextField);
    await tester.enterText(campos.at(0), 'Cardiologia');
    await tester.enterText(campos.at(1), 'Cuidados com o coração');
    await tester.tap(find.text('Adicionar Especialidade'));
    await tester.pumpAndSettle();

    await tester.enterText(campos.at(2), 'Dr. Roberto');
    await tester.enterText(campos.at(3), 'CRM123');
    await tester.tap(find.text('Adicionar Médico'));
    await tester.pumpAndSettle();

    await tester.enterText(campos.at(4), 'Maria Silva');
    await tester.enterText(campos.at(5), '30/09/2026');
    await tester.tap(find.text('Criar Consulta'));
    await tester.pumpAndSettle();

    expect(find.text('Sucesso'), findsOneWidget);
    await tester.tap(find.text('OK'));
    await tester.pumpAndSettle();

    expect(find.byType(ConsultaCard), findsOneWidget);
    expect(find.text('Maria Silva'), findsOneWidget);
    expect(find.text('1 consulta(s) agendada(s)'), findsOneWidget);

    await tester.tap(find.text('Ver Detalhes'));
    await tester.pumpAndSettle();
    expect(find.text('Detalhes da consulta'), findsOneWidget);
    await tester.pageBack();
    await tester.pumpAndSettle();

    await tester.tap(find.text('Confirmar'));
    await tester.pumpAndSettle();
    expect(find.text('CONFIRMADA'), findsOneWidget);
    expect(
      (await Storage.obterConsultas()).single.status,
      StatusConsulta.confirmada,
    );
    expect(tester.takeException(), isNull);
  });
}
