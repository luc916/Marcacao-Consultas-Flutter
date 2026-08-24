void main() {
  bool medicoAtivo = true;
  bool consultaAgendada = true;
  bool pacienteTemTelefone = false;
  bool pagamentoConfirmado = true;

  print('Médico ativo: $medicoAtivo');
  print('Consulta agendada: $consultaAgendada');
  print('Paciente tem telefone: $pacienteTemTelefone');
  print('Pagamento confirmado: $pagamentoConfirmado');

  if (medicoAtivo && consultaAgendada) {
    print('A consulta pode ser confirmada');
  }

  if (!pacienteTemTelefone) {
    print('Aviso: telefone do paciente não informado');
  }

  if (pagamentoConfirmado) {
    print('Liberado para atendimento');
  }
}
