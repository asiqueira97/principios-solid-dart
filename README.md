# Princípios do SOLID
Breve explicação sobre cada princípio do SOLID na programação orientada a objetos. Lembrando que esses princípios podem ser aplicados em qualquer linguagem orientada à objetos, nesse caso estou utlizando o Dart.

# Single Responsibility Principle (Princípio da Responsabilidade Única)

Cada módulo, classe ou função deve ter apenas uma razão de existir, ou seja, uma única responsabilidade. 
O objetivo deste princípio é reduzir a complexidade das classes, métodos ou módulos do software. No exemplo a seguir, é possível analisar uma classe que tem
mais de uma responsabilidade.

```
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
```

Neste exemplo, podemos reparar que a classe 'FinalizarPedido' tem responsabilidades extras que não deveria, ela pode ser considerada uma "God Class". Basicamente, uma "God Class" é uma classe que sabe demais. Bom, para resolver isso, podemos aplicar o princípio SRP. Vejamos:

```
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
```

A ideia deste princípio é separar essas regras em classes diferentes, desta forma cada classe será responsável por verificar suas condições. No futuro, outros desenvolvedores serão capazes de ler e entender esse método rapidamente porque ele foi feito de maneira simples.

# Open/closed Principle (Princípio Aberto/Fechado)

A definição deste princípio diz: "Classes, módulos ou funções devem ser abertos para extensões, mas fechados para modificação". A ideia é separar diferentes condições que seguem um princípio comum em classes diferentes, usando o primeiro princípio SOLID. No exemplo abaixo, o método de cálculo abrange todas as condições de desconto, tornando-o difícil de compreender.

```
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
```

Para melhorar este código usando o princípio Aberto/Fechado, será necessário usar o polimorfismo da programação orientada a objetos, para criar uma classe abstrata ou interface que irá determinar o método comum para cada classe concreta. No exemplo abaixo, foi criada uma interface com um método denominado 'calcular' e as classes que representam o tipo de produto, que irão implementar esta interface e determinar o comportamento do cálculo.

```
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
```

# Liskov Substitution Principle (Princípio de Substituição de Liskov)

Este princípio está intimamente ligado ao princípio Aberto/Fechado. O princípio informa que o objeto pode ser substituído por uma instância de seu subtipo (classe filha) sem alterar o comportamento do sistema. No exemplo abaixo, quando o subtipo 'TouroMecanico' é instanciado, ele também deve inserir uma instancia de 'Bateria' para seu funcionamento, o que a classe 'Touro' não espera para seu funcionamento.

```
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
```

#Interface Segregation Principle (Princípio de Segregação de Interface)

Nenhuma classe/cliente deve ser forçada a depender de métodos que não usa. No exemplo abaixo é possível ver uma interface chamada Developer que possui 3 métodos. No contexto de desenvolvimento de software, um desenvolvedor júnior está aprendendo como codificar ou melhorar sua capacidade de codificar e não como projetar uma solução de negócios corporativos. No entanto, a interface do desenvolvedor exigirá que a classe 'DesenvolvedorJunior' implemente todos esses métodos (programar, arquitetarAplicacao, revisarCodigo). Para evitar uma implementação, talvez os desenvolvedores lançem uma exceção como uma solução para este caso.

```
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
```

No exemplo abaixo, o Princípio de Segregação de Interface está sendo aplicado. A classe 'DesenvolvedorDartJunior' implementará apenas o método de desenvolvimento da interface DesenvolvedorJunior e o 'DesenvolvedorDartSenior' implementará todos os métodos da interface 'DesenvolvedorSenior' (no contexto real, o desenvolvedor sênior tem mais habilidades do que um desenvolvedor júnior).

```
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
```

# Dependency Inversion Principle (Principio de Inversão de Dependência)

- Módulos de alto nível não devem depender de módulos de baixo nível. Ambos devem depender de abstrações.
- Abstrações não devem depender de detalhes. Os detalhes devem depender das abstrações.
No exemplo abaixo, é possível ver diferentes módulos onde o módulo High-Level só se comunicará com o Low-Level através da interface UserDao (abstração usada para comunicação).

![DIP](https://user-images.githubusercontent.com/40249259/115915349-98ea6c80-a449-11eb-80f1-351c832cdb63.jpeg)

Todos os exemplos podem ser encontrados neste repositório.
