import 'package:fastcampus_diary/data/todo.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper{
  static final _databaseName = "todo.db";
  static final _databaseVersion = 1;
  static final todoTable = "todo";

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async{
    var databasePath = await getDatabasesPath();
    String path = join(databasePath , _databaseName);
    return await openDatabase(path, version: _databaseVersion , onCreate: _onCreate,
      onUpgrade: _onUpgrade);
  }

  // 앱을 깔고 처음 실행될 때 실행됨.
  Future _onCreate(Database db , int version ) async{
    await db.execute('''
    CREATE TABLE IF NOT EXISTS $todoTable(
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      date INTEGER DEFAULT 0,
      done INTEGER DEFAULT 0,
      title String,
      memo String,
      color INTEGER,
      category String
    )
    ''');
  }

  Future _onUpgrade(Database db , int oldVersion , int newVersion) async {

  }
  //Todo 입력, 수정, 불러오기
  Future<int> insertTodo(Todo todo) async {
    Database db = await instance.database;

    if(todo.id == null){
      // 새로 추가
      Map<String , dynamic> row = {
        // 아이디 정보
        "title" : todo.title,
        "date" : todo.date,
        "done" : todo.done,
        "memo" : todo.memo ,
        "color" : todo.color,
        "category" : todo.category
      };

      return await db.insert(todoTable, row);

    }else{
      // id가 있을 때
      Map<String , dynamic> row = {
        // 아이디 정보
        "title" : todo.title,
        "date" : todo.date,
        "done" : todo.done,
        "memo" : todo.memo ,
        "color" : todo.color,
        "category" : todo.category
      };

      return await db.update(todoTable, row, where : "id = ?" , whereArgs: [todo.id]);
    }
  }

  // TodoList전체 불러오기
  Future<List<Todo>> getAllTodo() async {
    Database db = await instance.database;
    List<Todo> todos = [];

    var queries = await db.query(todoTable);

    for(var q in queries){
      Todo(
          id : q["id"],
          title : q["title"],
          date : q["date"],
          done: q["done"],
          memo : q["memo"],
          category: q["category"],
          color : q["color"],
      );
    }

    return todos;
  }

  // 날짜 별로 db가져오기
  Future<List<Todo>> getTodoByDate(int date) async {
    Database db = await instance.database;
    List<Todo> todos = [];

    var queries = await db.query(todoTable , where: "date = ?" , whereArgs: [date]);

    for(var q in queries){
      Todo(
        id : q["id"],
        title : q["title"],
        date : q["date"],
        done: q["done"],
        memo : q["memo"],
        category: q["category"],
        color : q["color"],
      );
    }

    return todos;
  }

}