import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';


import '../service/model/lista_model.dart';

class DatabaseProvider {
  static final _databaseName = "canais_database.db";
  static final _databaseVersion = 1;

  static final table = 'canais';

  //static final columnId = '_id';
  static final columnTvgLogo = 'tvglogo';
  static final columnGroupTitle = 'grouptitle';
  static final columnName = 'name';
  static final columnLink = 'link';

  // torna esta classe singleton
  DatabaseProvider._privateConstructor();
  static final DatabaseProvider instance = DatabaseProvider._privateConstructor();

  // tem somente uma referência ao banco de dados
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  // abre o banco de dados e cria a tabela 'canais' se ela ainda não existir
  _initDatabase() async {
    String path = await getDatabasesPath();
    String fullPath = join(path, _databaseName);
    return await openDatabase(fullPath,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  Future close() async => _database!.close();

  // cria a tabela 'canais'
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            
            $columnTvgLogo TEXT,
            $columnGroupTitle TEXT,
            $columnName TEXT,
            $columnLink TEXT
          )
          ''');
  }

  // insere um novo canal na tabela 'canais'
  Future<List<Data>> insertCanal(List<Data> lista) async {
    Database db = await instance.database;
    var batch = db.batch();
    for (int i = 0; i < lista.length; i++) {
      batch.insert(table, lista[i].toMap(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
    await batch.commit();
    return lista;
  }


  // retorna todos os canais da tabela 'canais'
  Future<List<Data>> getAllCanais() async {
    //await close();
    Database db = await instance.database;
    final List<Map<String, Object?>> queryResult =
    await db.query(table);
    return queryResult.map((e) => Data.fromMap(e)).toList();
  }

  Future<List<Data>> getAllGroup(String group) async {
    Database db = await instance.database;
    List<String> columnsToSelect = [
      //DatabaseProvider.columnId,
      DatabaseProvider.columnTvgLogo,
      DatabaseProvider.columnName,
      DatabaseProvider.columnGroupTitle,
      DatabaseProvider.columnLink,
    ];
    String whereString = '${DatabaseProvider.columnGroupTitle} = ?';
    List<dynamic> whereArguments = [group];
    final List<Map<String,Object?>> queryResult = await db.query(table,columns: columnsToSelect,where: whereString,whereArgs: whereArguments);
    return queryResult.map((e) => Data.fromMap(e)).toList();
  }

  Future<int> getTotalRows() async {
    Database db = await instance.database;
    int? count = Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
    return count!;
  }

}






