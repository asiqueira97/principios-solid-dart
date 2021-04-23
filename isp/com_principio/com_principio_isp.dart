abstract class DesenvolvedorJunior {
  void programar();
}

abstract class DesenvolvedorSenior {
  void arquitetarAplicacao();
  void revisarCodigo();
}

class DesenvolvedorDartJunior implements DesenvolvedorJunior {
  @override
  void programar() {
    print('Junior apenas programa');
  }
}

class DesenvolvedorDartSenior implements DesenvolvedorSenior {
  @override
  void arquitetarAplicacao() {
    print('Arquitetar aplicação');
  }

  @override
  void revisarCodigo() {
    print('Revisar codigo');
  }
}
