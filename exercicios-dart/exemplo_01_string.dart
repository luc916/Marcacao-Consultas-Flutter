void main() {
  String nomePaciente = 'Carlos Andrade';
  String email = 'carlos@email.com';
  String cpf = '123.456.789-00';
  String crm = 'CRM12345';

  String frase1 = 'Paciente: ' + nomePaciente;
  String frase2 = 'Paciente: $nomePaciente | E-mail: $email';
  String frase3 = 'CRM do médico: $crm | CPF: $cpf';

  print(frase1);
  print(frase2);
  print(frase3);
  print(nomePaciente.toUpperCase());
  print(nomePaciente.toLowerCase());
  print(nomePaciente.length);
  print(nomePaciente.contains('Carlos'));
}
