import '../alto_nivel/user_dao.dart';

class UsuarioCadastroDao implements UsuarioDao {
  final List<String> usuarios = [];

  UsuarioCadastroDao() {
    usuarios.add('Alexandre 1');
    usuarios.add('Alexandre 2');
    usuarios.add('Alexandre 3');
  }

  @override
  List<String> todos() {
    return usuarios;
  }

  @override
  void salvar(String usuario) {
    usuarios.add(usuario);
  }
}
