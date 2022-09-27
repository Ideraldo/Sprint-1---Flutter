import 'package:sprint1_cadastro/models/usuario.dart';

import '../database/database_manager.dart';

class UsuarioRepository {
  Future<List<Usuario>> listarUsuarios() async {
    final db = await DatabaseManager().getDatabase();
    final List<Map<String, dynamic>> rows = await db.rawQuery('''
          SELECT 
            usuarios.id, 
            usuarios.nomeUsuario,
            usuarios.cpfUsuario,
            usuarios.rendaMensal, 
            usuarios.valorMaximoParcela, 
            usuarios.nomeFiador,
            usuarios.cpfFiador
          FROM usuarios
''');
    return rows
        .map(
          (row) => Usuario(
            id: row['id'],
            nomeUsuario: row['nomeUsuario'],
            cpfUsuario: row['cpfUsuario'],
            rendaMensal: row['rendaMensal'],
            valorMaximoParcela: row['valorMaximoParcela'],
            nomeFiador: row['nomeFiador'],
            cpfFiador: row['cpfFiador'],
          ),
        )
        .toList();
  }

  Future<void> cadastrarUsuario(Usuario usuario) async {
    final db = await DatabaseManager().getDatabase();

    db.insert("usuarios", {
      "id": usuario.id,
      "nomeUsuario": usuario.nomeUsuario,
      "cpfUsuario": usuario.cpfUsuario,
      "rendaMensal": usuario.rendaMensal,
      "valorMaximoParcela": usuario.valorMaximoParcela,
      "nomeFiador": usuario.nomeFiador,
      "cpfFiador": usuario.cpfFiador,
    });
  }

  Future<void> removerUsuario(int id) async {
    final db = await DatabaseManager().getDatabase();
    await db.delete('usuarios', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> editarUsuario(Usuario usuario) async {
    final db = await DatabaseManager().getDatabase();
    return db.update(
        'usuarios',
        {
          "id": usuario.id,
          "nomeUsuario": usuario.nomeUsuario,
          "cpfUsuario": usuario.cpfUsuario,
          "rendaMensal": usuario.rendaMensal,
          "valorMaximoParcela": usuario.valorMaximoParcela,
          "nomeFiador": usuario.nomeFiador,
          "cpfFiador": usuario.cpfFiador,
        },
        where: 'id = ?',
        whereArgs: [usuario.id]);
  }
}
