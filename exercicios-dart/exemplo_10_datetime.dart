void main() {
  DateTime dataConsulta = DateTime(2026, 8, 10);
  DateTime agora = DateTime.now();

  print('Data da consulta: $dataConsulta');
  print('Agora: $agora');
  print('Ano: ${dataConsulta.year}');
  print('Mês: ${dataConsulta.month}');
  print('Dia: ${dataConsulta.day}');

  DateTime proximaSemana = dataConsulta.add(const Duration(days: 7));
  print('Retorno sugerido: $proximaSemana');
}
