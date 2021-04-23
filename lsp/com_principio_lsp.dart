class Touro {
  void pular() {
    print('Touro pulando');
  }
}

class Bateria {
  final int carga;
  Bateria(this.carga);

  bool get temCarga {
    return carga > 0;
  }
}

class TouroMecanico extends Touro {
  final Bateria bateria;
  TouroMecanico(this.bateria);

  @override
  void pular() {
    if (bateria == null || !bateria.temCarga) {
      print('Erro: Touro mecânico sem bateria.');
    } else {
      print('Touro pulando');
    }
  }
}

class AplicacaoLsp {
  void executar() {
    Touro touroMecanico1 = Touro();
    touroMecanico1.pular();

    Bateria bateria = Bateria(52);
    TouroMecanico touroMecanico2 = TouroMecanico(bateria);
    touroMecanico2.pular();
  }
}
