class Paciente {
  int id;
  String nome;
  String cpf;
  String email;
  String? telefone;

  Paciente({
    required this.id,
    required this.nome,
    required this.cpf,
    required this.email,
    this.telefone,
  });

  String descrever() {
    final fone = telefone ?? 'não informado';
    return 'Paciente $nome | CPF: $cpf | Tel: $fone';
  }
}

class Consulta {
  int id;
  String nomeMedico;
  Paciente paciente;
  double valor;
  String status;

  Consulta({
    required this.id,
    required this.nomeMedico,
    required this.paciente,
    required this.valor,
    required this.status,
  });

  void confirmar() {
    if (status == 'agendada') {
      status = 'confirmada';
    }
  }

  String resumo() {
    return 'Consulta #$id | ${paciente.nome} com $nomeMedico | '
        '$status | R\$ ${valor.toStringAsFixed(2)}';
  }
}

void main() {
  final paciente = Paciente(
    id: 1,
    nome: 'Carlos Andrade',
    cpf: '123.456.789-00',
    email: 'carlos@email.com',
    telefone: '(11) 98765-4321',
  );

  final consulta = Consulta(
    id: 1,
    nomeMedico: 'Dr. Roberto Silva',
    paciente: paciente,
    valor: 350.0,
    status: 'agendada',
  );

  print(paciente.descrever());
  print(consulta.resumo());
  consulta.confirmar();
  print(consulta.resumo());
}
