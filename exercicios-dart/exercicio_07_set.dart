void main() {
  Set<String> especialidades = {
    'Cardiologia',
    'Pediatria',
    'Dermatologia',
  };

  especialidades.add('Cardiologia');
  especialidades.add('Ortopedia');

  print('Especialidades: $especialidades');
  print('Possui Pediatria? ${especialidades.contains('Pediatria')}');
  print('Quantidade de especialidades únicas: ${especialidades.length}');
}
