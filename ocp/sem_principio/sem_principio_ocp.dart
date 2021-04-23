class Produto {
  final String nome;
  final int quantidade;
  final TipoProduto tipo;
  final double valor;

  Produto(this.nome, this.quantidade, this.tipo, this.valor);
}

enum TipoProduto { ELETRONICO, MOVEL }

class Desconto {
  final double valorMinimoEletronico = 5000;
  final double descontoMinimoEletronico = 0.9;
  final double descontoMaximoEletronico = 0.75;
  final double descontoMaximoMoveis = 0.75;

  double calcular(double preco, TipoProduto tipo) {
    double precoComDesconto = preco;
    if (tipo == TipoProduto.ELETRONICO) {
      if (preco > valorMinimoEletronico) {
        precoComDesconto = preco * descontoMaximoEletronico;
      } else {
        precoComDesconto = preco * descontoMinimoEletronico;
      }
    } else if (tipo == TipoProduto.MOVEL) {
      precoComDesconto = preco * descontoMaximoMoveis;
    }

    print('Valor com Desconto: $precoComDesconto');
    return precoComDesconto;
  }
}

class CalcularDesconto {
  void executar() {
    print('* Código sem o OCP aplicado. *\n');

    Produto produto = Produto('Painel de TV MDF', 1, TipoProduto.MOVEL, 50.0);
    Desconto().calcular(produto.valor, produto.tipo);
  }
}
