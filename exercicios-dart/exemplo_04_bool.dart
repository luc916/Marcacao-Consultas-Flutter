void main() {
  bool medicoAtivo = true;
  bool consultaConfirmada = false;
  bool pacientePossuiTelefone = true;

  print('Médico ativo? $medicoAtivo');
  print('Consulta confirmada? $consultaConfirmada');
  print('Paciente possui telefone? $pacientePossuiTelefone');

  if (medicoAtivo) {
    print('Este médico pode atender.');
  } else {
    print('Este médico está inativo.');
  }

  if (!consultaConfirmada) {
    print('A consulta ainda não foi confirmada.');
  }
}
