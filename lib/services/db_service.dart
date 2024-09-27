import 'package:employee_management/models/employee_model.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await initDB();
    return _database!;
  }

  Future<Database> initDB() async {
    String path = join(await getDatabasesPath(), 'employee.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE employees(
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            username TEXT,
            password TEXT,
            mobile TEXT,
            email TEXT,
            employeeId TEXT,
            designation TEXT
          )
        ''');
      },
    );
  }

  Future<void> insertEmployee(Employee employee) async {
    final db = await database;
    await db.insert('employees', employee.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Employee?> login(String username, String password) async {
    final db = await database;
    final result = await db.query('employees',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password]);

    if (result.isNotEmpty) {
      return Employee.fromMap(result.first);
    }
    return null;
  }
}
