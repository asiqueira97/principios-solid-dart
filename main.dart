import 'lsp/com_principio_lsp.dart';
import 'ocp/com_principio/com_principio_ocp.dart';
import 'srp/com_principio/com_principio_srp.dart';

void main() {
  FinalizarPedido().finalizar();
  CalcularDesconto().executar();
  AplicacaoLsp().executar();

  // Demais Principios não precisa de execução
}
