void main() {
  Map<String, dynamic> consulta = {
    'id': 1,
    'paciente': 'Carlos Andrade',
    'medico': 'Dr. Roberto Silva',
    'valor': 350.0,
    'status': 'agendada',
    'telefone': null,
  };

  print('Paciente: ${consulta['paciente']}');
  print('Médico: ${consulta['medico']}');
  print('Valor: R\$ ${consulta['valor']}');

  consulta['status'] = 'confirmada';
  consulta['telefone'] = '(11) 98765-4321';

  consulta.forEach((chave, valor) {
    print('$chave => $valor');
  });
}
