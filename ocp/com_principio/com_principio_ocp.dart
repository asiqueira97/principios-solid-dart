class Produto {
  final String nome;
  final int quantidade;
  final TipoProduto tipo;
  final double valor;

  Produto(this.nome, this.quantidade, this.tipo, this.valor);
}

enum TipoProduto { ELETRONICO, MOVEL }

abstract class Desconto {
  double descontar(double preco);
}

class DescontoEletronico implements Desconto {
  final double valorMinimoEletronico = 5000;
  final double descontoMinimoEletronico = 0.9;
  final double descontoMaximoEletronico = 0.75;

  @override
  double descontar(double preco) {
    if (preco > valorMinimoEletronico) {
      return preco * descontoMaximoEletronico;
    }

    return preco * descontoMinimoEletronico;
  }
}

class DescontoMovel implements Desconto {
  final double descontoMaximoMoveis = 0.75;

  @override
  double descontar(double preco) {
    return preco * descontoMaximoMoveis;
  }
}

class CalcularDesconto {
  void executar() {
    print('* Código com o OCP aplicado. *\n');

    Produto produto1 = Produto('Painel de TV MDF', 1, TipoProduto.MOVEL, 50.0);
    print(DescontoMovel().descontar(produto1.valor));

    Produto produto2 =
        Produto('Tablet Samsung', 1, TipoProduto.ELETRONICO, 950.0);

    print(DescontoEletronico().descontar(produto2.valor));
  }
}
