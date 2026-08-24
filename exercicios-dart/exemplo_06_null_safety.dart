void main() {
  String? telefone;
  String? observacoes;

  print(telefone);
  print(observacoes);

  telefone = '(11) 98765-4321';
  observacoes = 'Consulta de rotina';

  String telefoneExibicao = telefone ?? 'Telefone não informado';
  String obsExibicao = observacoes ?? 'Sem observações';

  print(telefoneExibicao);
  print(obsExibicao);

  if (telefone != null) {
    print('Telefone informado com ${telefone.length} caracteres');
  }
}
