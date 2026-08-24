void main() {
  Map<String, dynamic> paciente = {
    'id': 1,
    'nome': 'Carlos Andrade',
    'cpf': '123.456.789-00',
    'email': 'carlos@email.com',
    'telefone': '(11) 98765-4321',
  };

  print(paciente['nome']);
  print(paciente['email']);

  paciente['telefone'] = '(11) 90000-0000';
  paciente['ativo'] = true;

  print(paciente);

  paciente.forEach((chave, valor) {
    print('$chave => $valor');
  });
}
