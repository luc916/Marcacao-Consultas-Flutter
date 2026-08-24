enum StatusConsulta { agendada, confirmada, cancelada }

void main() {
  DateTime dataConsulta = DateTime(2026, 8, 24, 10, 30);
  StatusConsulta status = StatusConsulta.agendada;

  ({String paciente, String medico, double valor}) resumo = (
    paciente: 'Carlos Andrade',
    medico: 'Dr. Roberto Silva',
    valor: 350.0,
  );

  print(
    'Data: ${dataConsulta.day}/${dataConsulta.month}/${dataConsulta.year}',
  );
  print('Status atual: ${status.name}');
  print('Paciente: ${resumo.paciente}');
  print('Médico: ${resumo.medico}');
  print('Valor: R\$ ${resumo.valor.toStringAsFixed(2)}');

  status = StatusConsulta.confirmada;
  print('Novo status: ${status.name}');

  DateTime dataRetorno = dataConsulta.add(const Duration(days: 7));
  print(
    'Retorno: ${dataRetorno.day}/${dataRetorno.month}/${dataRetorno.year}',
  );
}
