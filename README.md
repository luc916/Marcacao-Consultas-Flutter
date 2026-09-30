# Marcacao-Consultas-Flutter
Aprendizado de Dart e projeto Flutter - Sistema de Marcação de Consultas

## Aula de 28/09/2026 — formulário e CRUD

- Formulário para cadastrar uma nova consulta.
- Seleção de paciente, médico, data e horário.
- Validação dos campos obrigatórios e do valor da consulta.
- Geração automática do próximo ID.
- Persistência da nova consulta com `shared_preferences`.
- Exclusão com confirmação na tela de detalhes.
- Estado vazio quando não houver consultas cadastradas.

### Aula de 28/09 — formulário e CRUD

1. Clique em **Nova consulta**.
2. Tente salvar o formulário vazio e confira as mensagens de validação.
3. Selecione paciente e médico, informe um valor, escolha data e horário e
   salve.
4. Atualize a página e confira que a nova consulta continua na lista.
5. Abra **Ver Detalhes**, clique em **Excluir consulta** e confirme.

## Aula de 14/09/2026 — lista, mock e persistência local

- Lista de três consultas com `ListView.separated`.
- Confirmar e cancelar pelo ID, sem alterar os outros cards.
- Dados de exemplo separados em `lib/src/data/consultas_mock.dart`.
- `ConsultaStorage` carrega e salva a lista em JSON com `shared_preferences`.
- Tela de detalhes somente para leitura, aberta com `Navigator.push`.

### Executar

```sh
flutter pub get
flutter run -d chrome --web-port 7357
```

A porta fixa permite reencontrar o mesmo armazenamento local ao parar e iniciar
o app no mesmo navegador. O mock só é usado quando ainda não há dados salvos.

### Conferir o resultado da aula

1. Na primeira execução, Carlos e Ana aparecem agendados; João, confirmado.
2. Confirme Carlos e confira que Ana continua agendada.
3. Cancele Ana e abra os detalhes de uma consulta. Volte pela seta do topo.
4. Atualize a página: Carlos e João continuam confirmados; Ana, cancelada.

```sh
flutter analyze lib test
flutter test
```

Os testes conferem a conversão JSON, o carregamento inicial, a preservação de
dados salvos, as ações por ID, a navegação e a leitura após recriar o app.
