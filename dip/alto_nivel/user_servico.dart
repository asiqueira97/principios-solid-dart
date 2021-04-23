import 'user_dao.dart';

class UsuarioServico {
  final UsuarioDao usuarioDao;

  UsuarioServico(this.usuarioDao);

  List<String> todos() {
    usuarioDao.todos();
  }

  void salvar(String usuario) {
    usuarioDao.salvar(usuario);
  }
}
