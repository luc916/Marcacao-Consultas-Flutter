void main() {
  int idPaciente = 15;
  int idMedico = 8;
  int idConsulta = 40;
  int idadePaciente = 61;
  int quantidadeConsultasMes = 4;

  print('Soma dos IDs: ${idPaciente + idMedico}');
  print('Próximo ID de consulta: ${idConsulta + 1}');

  if (idadePaciente >= 60) {
    print('Paciente prioritário');
  } else {
    print('Paciente comum');
  }

  print('Dobro de consultas no mês: ${quantidadeConsultasMes * 2}');
}
