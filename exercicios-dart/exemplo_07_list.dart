void main() {
  List<String> status = ['agendada', 'confirmada', 'cancelada'];
  List<double> valores = [150.0, 350.0, 500.0];
  List<int> ids = [1, 2, 3];

  print('Primeiro status: ${status[0]}');
  print('Quantidade de status: ${status.length}');

  valores.add(200.0);
  print('Valores após add: $valores');

  for (final item in status) {
    print('Status atual: $item');
  }

  List<double> caras = valores.where((valor) => valor >= 300).toList();
  List<String> textos = ids.map((id) => 'Consulta #$id').toList();

  print('Consultas caras: $caras');
  print('Textos: $textos');
}
