void main() {
  double valorConsulta = 350.0;
  double desconto = 35.5;
  double valorFinal = valorConsulta - desconto;

  print('Valor original: R\$ ${valorConsulta.toStringAsFixed(2)}');
  print('Desconto: R\$ ${desconto.toStringAsFixed(2)}');
  print('Valor final: R\$ ${valorFinal.toStringAsFixed(2)}');

  double c1 = 200.0;
  double c2 = 350.0;
  double c3 = 500.0;
  double media = (c1 + c2 + c3) / 3;

  print('Média das consultas: R\$ ${media.toStringAsFixed(2)}');
}
