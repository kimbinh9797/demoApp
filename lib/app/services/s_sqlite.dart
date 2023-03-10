// ignore_for_file: non_constant_identifier_names

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../data/models/todo.dart';
import '../data/models/user.dart';

const dbName = 'EMDB.db';
const tableUser = 'user';
const tableTodo = 'todo';

class SqliteServices {
  factory SqliteServices() => _instance;

  SqliteServices._internal();

  static final SqliteServices _instance = SqliteServices._internal();
  Database? _SMDB;

  /// open DB connection
  Future<void> openDB() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, dbName);
    if (_SMDB != null) {
      if (_SMDB!.isOpen) {
        return;
      }
    }
    _SMDB = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute('''CREATE TABLE IF NOT EXISTS $tableUser
             (id INTEGER PRIMARY KEY AUTOINCREMENT,
             name TEXT,
             email TEXT,
             password TEXT)''');
        await db.execute('''CREATE TABLE IF NOT EXISTS $tableTodo
             (id INTEGER PRIMARY KEY AUTOINCREMENT,
             id_user INTEGER,
             title TEXT,
             description TEXT)''');
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
          id: element["id"] as int,
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

  Future<int> deleteTodo(Todo item)async{
     try {
    final result = await _SMDB!.delete(tableTodo, where: "id = ?", whereArgs: [item.id]);
     return result;
    } on Exception {
      return 0;
    }
  }
}
