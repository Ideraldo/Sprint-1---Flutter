import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseManager {
  Future<Database> getDatabase() async {
    final path = join(await getDatabasesPath(), 'sprint.db');
    return openDatabase(path, version: 4, onCreate: _onCreate);
  }

  _onCreate(Database db, int version) async {
    await db.execute(_usuarios);
    await db.insert('usuarios', {
      'nomeUsuario': 'Marcos da Silva',
      'cpfUsuario': '123.456.789-85',
      'rendaMensal': 2500.40,
      'valorMaximoParcela': 1000.00,
      'nomeFiador': 'Ideraldo Rui do Carmo Biecco',
      'cpfFiador': '123.456.789-95'
    });
  }

  String get _usuarios => '''
    CREATE TABLE IF NOT EXISTS usuarios (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nomeUsuario TEXT,
      cpfUsuario TEXT,
      rendaMensal REAL, 
      valorMaximoParcela REAL,
      nomeFiador TEXT,
      cpfFiador TEXT
    );
  ''';
}
