enum StatusConsulta { agendada, confirmada, cancelada }

class Consulta {
  final int id;
  final String paciente;
  final String medico;
  final String especialidade;
  final double valor;
  final bool pagamentoConfirmado;
  final num registro;
  final String? telefone;
  final DateTime data;
  StatusConsulta status;

  Consulta({
    required this.id,
    required this.paciente,
    required this.medico,
    required this.especialidade,
    required this.valor,
    required this.pagamentoConfirmado,
    required this.registro,
    required this.data,
    required this.status,
    this.telefone,
  });

  void confirmar() {
    if (status == StatusConsulta.agendada) {
      status = StatusConsulta.confirmada;
    }
  }

  void cancelar() {
    if (status == StatusConsulta.agendada) {
      status = StatusConsulta.cancelada;
    }
  }
}

void main() {
  String clinica = 'Clínica Heart Care';

  Set<String> especialidades = {
    'Cardiologia',
    'Dermatologia',
  };

  Map<String, dynamic> paciente = {
    'nome': 'Carlos Andrade',
    'email': 'carlos@email.com',
    'idade': 35,
  };

  List<Consulta> consultas = [
    Consulta(
      id: 1,
      paciente: 'Carlos Andrade',
      medico: 'Dr. Roberto Silva',
      especialidade: 'Cardiologia',
      valor: 350.0,
      pagamentoConfirmado: true,
      registro: 1001,
      telefone: '(11) 98765-4321',
      data: DateTime(2026, 8, 24, 14, 30),
      status: StatusConsulta.agendada,
    ),
    Consulta(
      id: 2,
      paciente: 'Ana Souza',
      medico: 'Dra. Marina Costa',
      especialidade: 'Dermatologia',
      valor: 280.5,
      pagamentoConfirmado: false,
      registro: 1002.5,
      data: DateTime(2026, 8, 25, 9),
      status: StatusConsulta.agendada,
    ),
  ];

  ({String paciente, double valor}) resumoRapido = (
    paciente: consultas.first.paciente,
    valor: consultas.first.valor,
  );

  consultas[0].confirmar();
  consultas[1].cancelar();

  double total = consultas.fold(
    0.0,
    (soma, consulta) => soma + consulta.valor,
  );

  print('======= $clinica =======');
  print('Paciente do cadastro: ${paciente['nome']}');
  print('Quantidade de consultas: ${consultas.length}');
  print('Soma dos valores: R\$ ${total.toStringAsFixed(2)}');
  print('Especialidades únicas: $especialidades');
  print(
    'Resumo: ${resumoRapido.paciente} - '
    'R\$ ${resumoRapido.valor.toStringAsFixed(2)}',
  );

  for (final consulta in consultas) {
    print('Consulta #${consulta.id}: ${consulta.status.name}');
    print('Pagamento confirmado: ${consulta.pagamentoConfirmado}');
    print('Registro: ${consulta.registro}');
    print('Telefone: ${consulta.telefone ?? 'não informado'}');
  }
}
