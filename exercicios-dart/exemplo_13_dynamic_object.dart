void main() {
  dynamic qualquer = 'Texto';
  print(qualquer);

  qualquer = 10;
  print(qualquer);

  Object dado = 'Paciente';
  print(dado);

  if (dado is String) {
    print(dado.toUpperCase());
  }
}
