class Pagamento {
  static void debitarValor(double valor) {
    print('* Debitando R\$ $valor da conta');
  }
}

class Saldo {
  static bool validarSaldo(double saldo, double valorProduto) {
    return (saldo >= valorProduto);
  }

  static double get valorAtual {
    return 60.0;
  }
}

class NotaFiscal {
  static void emitirNotaFiscal(Produto produto) {
    print('Nota Fiscal emitida com Sucesso!');
  }
}

class Produto {
  final String nome;
  final int quantidade;
  final double valor;

  Produto(this.nome, this.quantidade, this.valor);
}

class FinalizarPedido {
  void finalizar() {
    print('* Código com o SRP aplicado. *\n');

    Produto produto = Produto('Mouse Vertical', 1, 61);
    double saldoEmConta = Saldo.valorAtual;

    bool saldoValido = Saldo.validarSaldo(saldoEmConta, produto.valor);
    if (saldoValido) {
      Pagamento.debitarValor(produto.valor);
      NotaFiscal.emitirNotaFiscal(produto);
    } else {
      print('Saldo Insuficiente');
    }
  }
}
