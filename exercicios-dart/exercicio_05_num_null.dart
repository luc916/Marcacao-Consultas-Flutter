void main() {
  num registro = 10;
  print('Registro inteiro: $registro');

  registro = 10.5;
  print('Registro decimal: $registro');

  String? telefone;
  String? observacoes = 'Paciente possui alergia a dipirona';

  print('Telefone: ${telefone ?? 'não informado'}');

  if (observacoes != null) {
    print('Tamanho das observações: ${observacoes.length}');
  }
}
