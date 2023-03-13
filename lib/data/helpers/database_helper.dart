// ignore_for_file: non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../domain/entities/todo.dart';
import '../../domain/entities/user.dart';

const dbName = 'EMDB.db';
const tableUser = 'user';
const tableTodo = 'todo';

class DatabaseHelper {
  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  static final DatabaseHelper _instance = DatabaseHelper._internal();
  Database? _SMDB;

  Map<int, String> migrationScripts = {
    1: '''CREATE TABLE IF NOT EXISTS $tableUser
             (id INTEGER PRIMARY KEY AUTOINCREMENT,
             name TEXT,
             email TEXT,
             password TEXT)''',
    2: '''CREATE TABLE IF NOT EXISTS $tableTodo
             (id INTEGER PRIMARY KEY AUTOINCREMENT,
             id_user INTEGER,
             title TEXT,
             description TEXT)''',
  };

  /// open DB connection
  Future<void> openDB() async {
    // Get a location using getDatabasesPath
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);
    if (_SMDB != null) {
      if (_SMDB!.isOpen) {
        return;
      }
    }
    int nbrMigrationScripts = migrationScripts.length;

    _SMDB = await openDatabase(
      path,
      version: nbrMigrationScripts,
      onCreate: (Database db, int version) async {
        for (int i = 1; i <= nbrMigrationScripts; i++) {
          await db.execute(migrationScripts[i].toString());
        }
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        for (int i = oldVersion + 1; i <= newVersion; i++) {
          await db.execute(migrationScripts[i].toString());
        }
      },
    );
  }

  //Table User
  Future<User?> getUser(String email, String password) async {
    final map = await _SMDB!.query(
      tableUser,
      where: "email = ? AND password = ?",
      whereArgs: [email, password],
    );

    if (map.isEmpty) {
      return null;
    }
    return User(
      email: map[0]['email'] as String,
      password: map[0]['password'] as String,
    );
  }

  Future<int> insertUser(User user) async {
    final values = {
      "name": user.name,
      "email": user.email,
      "password": user.password
    };

    try {
      final existUser = await getUser(user.email!, user.password!);
      if (existUser != null) {
        return 0;
      } else {
        final result = await _SMDB!.insert(tableUser, values);
        return result;
      }
    } on Exception {
      return 0;
    }
  }

  //Table Todo
  Future<List<Todo>> getTodoList() async {
    final map = await _SMDB!.query(tableTodo);

    if (map.isEmpty) {
      return [];
    }
    List<Todo> todoList = [];
    for (var element in map) {
      todoList.add(
        Todo(
          idUser: element["id_user"] as int,
          title: element["title"] as String,
          description: element["description"] as String,
        ),
      );
    }
    return todoList;
  }

  Future<int> insertTodo(Todo item) async {
    final values = {
      "id_user": item.idUser,
      "title": item.title,
      "description": item.description
    };

    try {
      final result = await _SMDB!.insert(tableTodo, values);
      return result;
    } on Exception {
      return 0;
    }
  }

  Future<int> deleteTodo(Todo item) async {
    try {
      final result =
          await _SMDB!.delete(tableTodo, where: "id = ?", whereArgs: [item.id]);
      return result;
    } on Exception {
      return 0;
    }
  }
}
