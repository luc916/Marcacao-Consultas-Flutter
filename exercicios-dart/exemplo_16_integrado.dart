enum StatusConsulta { agendada, confirmada, cancelada }

void main() {
  String clinica = 'Clínica Heart Care';
  int id = 1;
  double valor = 350.0;
  bool medicoAtivo = true;
  DateTime data = DateTime(2026, 8, 10);
  StatusConsulta status = StatusConsulta.agendada;
  String? observacoes = 'Consulta de rotina';

  List<String> procedimentos = ['ECG', 'Avaliação clínica'];
  Set<String> especialidades = {'Cardiologia', 'Clínico Geral'};
  Map<String, dynamic> paciente = {
    'nome': 'Carlos Andrade',
    'cpf': '123.456.789-00',
    'telefone': null,
  };

  print('======= SISTEMA DE CONSULTAS (CONSOLE) =======');
  print('Clínica: $clinica');
  print('Consulta #$id');
  print('Data: ${data.day}/${data.month}/${data.year}');
  print('Valor: R\$ ${valor.toStringAsFixed(2)}');
  print('Médico ativo: $medicoAtivo');
  print('Status: ${status.name}');
  print('Observações: ${observacoes ?? 'Sem observações'}');
  print('Procedimentos: $procedimentos');
  print('Especialidades: $especialidades');
  print('Paciente: ${paciente['nome']}');
  print('Telefone: ${paciente['telefone'] ?? 'não informado'}');

  if (status == StatusConsulta.agendada && medicoAtivo) {
    status = StatusConsulta.confirmada;
    print('Status atualizado para: ${status.name}');
  }
}
