void main() {
  double consulta1 = 180.0;
  double consulta2 = 350.5;
  double consulta3 = 500.0;

  double total = consulta1 + consulta2 + consulta3;
  double media = total / 3;
  double consultaMaisCaraComDesconto = consulta3 * 0.90;

  print('Total: R\$ ${total.toStringAsFixed(2)}');
  print('Média: R\$ ${media.toStringAsFixed(2)}');
  print(
    'Consulta mais cara com 10% de desconto: '
    'R\$ ${consultaMaisCaraComDesconto.toStringAsFixed(2)}',
  );
}
