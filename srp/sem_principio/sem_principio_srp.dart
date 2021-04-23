class Produto {
  final String nome;
  final int quantidade;
  final double valor;

  Produto(this.nome, this.quantidade, this.valor);
}

class FinalizarPedido {
  bool validarSaldo(double saldo, double valorProduto) {
    return (saldo >= valorProduto);
  }

  void debitarValor(double valor) {
    print('* Debitando R\$ $valor da conta');
  }

  void emitirNotaFiscal(Produto produto) {
    print('Nota Fiscal emitida com Sucesso!\nProduto: ${produto.nome}');
  }

  void finalizar() {
    print('* Código sem o SRP aplicado. *\n');

    Produto produto = Produto('Mouse Vertical', 1, 20.99);

    double saldoEmConta = 60.0;

    if (validarSaldo(saldoEmConta, produto.valor)) {
      debitarValor(produto.valor);
      emitirNotaFiscal(produto);
    } else {
      print('Saldo Insuficiente');
    }
  }
}
