abstract class Desenvolvedor {
  void programar();
  void arquitetarAplicacao();
  void revisarCodigo();
}

class DesenvolvedorJunior implements Desenvolvedor {
  @override
  void arquitetarAplicacao() =>
      print('Arquitetar aplicação - Dev Junior não deve ter essa função.');

  @override
  void programar() => print('Programar aplicação');

  @override
  void revisarCodigo() =>
      print('Revisar aplicação - Dev Junior não deve ter essa função.');

  void trabalhar() {
    arquitetarAplicacao();
    programar();
    revisarCodigo();
  }
}

class DesenvolvedorSenior implements Desenvolvedor {
  @override
  void arquitetarAplicacao() => print('Arquitetar aplicação.');

  @override
  void programar() => print('Programar aplicação.');

  @override
  void revisarCodigo() => print(
      'Revisar aplicação - Desenvolvedor Senior não deve ter essa função.');

  void trabalhar() {
    arquitetarAplicacao();
    programar();
    revisarCodigo();
  }
}
