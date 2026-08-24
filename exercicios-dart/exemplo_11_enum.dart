enum StatusConsulta { agendada, confirmada, cancelada }

void main() {
  StatusConsulta status = StatusConsulta.agendada;

  print('Status atual: ${status.name}');

  if (status == StatusConsulta.agendada) {
    print('A consulta pode ser confirmada ou cancelada.');
  }

  status = StatusConsulta.confirmada;
  print('Novo status: ${status.name}');
}
