void main() {
  String nomePaciente = 'Lucas Nishiwaki';
  String nomeMedico = 'Dr. Roberto Silva';
  String especialidade = 'Cardiologia';
  String emailPaciente = 'lucas@email.com';

  print('Ficha da consulta');
  print('Paciente: $nomePaciente');
  print('Médico: $nomeMedico');
  print('Especialidade: $especialidade');
  print('E-mail: $emailPaciente');
  print('Paciente em maiúsculas: ${nomePaciente.toUpperCase()}');
  print('Quantidade de caracteres do e-mail: ${emailPaciente.length}');
  print('O e-mail contém @? ${emailPaciente.contains('@')}');
}
