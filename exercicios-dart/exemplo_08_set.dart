void main() {
  Set<String> especialidades = {
    'Cardiologia',
    'Dermatologia',
    'Pediatria',
  };

  print(especialidades);

  especialidades.add('Cardiologia');
  especialidades.add('Ortopedia');

  print('Após inserções: $especialidades');
  print('Contém Pediatria? ${especialidades.contains('Pediatria')}');
}
