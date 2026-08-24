void main() {
  List<String> status = ['agendada', 'confirmada', 'cancelada'];
  List<double> valores = [180.0, 250.0, 350.0, 500.0];

  for (final item in status) {
    print('Status da consulta: $item');
  }

  valores.add(420.0);

  List<double> valoresMaiores = valores
      .where((valor) => valor >= 300)
      .toList();

  print('Valores a partir de R\$ 300,00: $valoresMaiores');
  print('Quantidade total de preços: ${valores.length}');
}
