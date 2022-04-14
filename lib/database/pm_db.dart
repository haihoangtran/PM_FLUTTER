import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'package:pm_flutter/resources/const/db_const.dart';

class PMDatabase {
  // Make a singleton instance
  PMDatabase._privateConstructor();
  static final PMDatabase instance = PMDatabase._privateConstructor();

  // create database properties
  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    return await _initDatabase();
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), databaseName);
    return await openDatabase(path,
        version: databaseVersion, onCreate: _onCreate, onUpgrade: _onUpgrade);
  }

  Future _onCreate(Database db, int version) async {
    await _createUsersTable(db);
    await _createCardsTable(db);
    await _createBudgetsTable(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    await _createUsersTable(db);
    await _createCardsTable(db);
    await _createBudgetsTable(db);
  }

  // ----------------   PRIVATE FUNCTIONS   ---------------------

  // selectedField: 1 - selected
  //                0: no selected
  Future<void> _createUsersTable(Database db) async {
    await db.execute('''
      Create table if not exists $userTableName (
        $userIdField integer Primary Key Autoincrement,
        $userNameField Text not null,
        $userBalanceField real,
        $userIsSelectedField integer        
      )
    ''');
  }

  Future<void> _createCardsTable(Database db) async {
    await db.execute('''
      Create table if not exists $cardsTableName (
        $cardsIdField integer Primary Key Autoincrement,
        $cardsNameField Text not null,
        $cardBalanceField real,
        $cardUserIdField integer,
        foreign key($cardUserIdField) references $userTableName($userIdField)      
      )
    ''');
  }

  Future<void> _createBudgetsTable(Database db) async {
    await db.execute('''
      Create table if not exists $budgetsTableName (
        $budgetsIdField integer Primary Key Autoincrement,
        $budgetsPlaceField Text not null,
        $budgetsAmountField real,
        $budgetsDateField text,
        $budgetsTypeField integer,
        $budgetsUserIdField integer,
        $budgetsCardIdField integer,
        foreign key($budgetsUserIdField) references $userTableName($userIdField),
        foreign key($budgetsCardIdField) references $cardsTableName($cardsIdField)
      ) 
    ''');
  }
}
