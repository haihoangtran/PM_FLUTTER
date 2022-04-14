import 'package:pm_flutter/database/pm_db.dart';
import 'package:pm_flutter/model/user_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:pm_flutter/resources/const/db_const.dart';

class UsersDB {
  late PMDatabase dbInstance;

  UsersDB(this.dbInstance);

  Future<void> addUser(UserModel user) async {
    Database db = await dbInstance.database;
    await db.insert(userTableName, {
      userNameField: user.username,
      userBalanceField: user.getBalance,
      userIsSelectedField: user.isSelected
    });
  }

  Future<List<UserModel>> getAllUsers() async {
    Database db = await dbInstance.database;
    var res = await db.query(userTableName);
    return res.isNotEmpty ? res.map((u) => UserModel.fromJson(u)).toList() : [];
  }

  Future<List<UserModel>> getSelectedUser() async {
    Database db = await dbInstance.database;
    var res = await db.query(userTableName, where: '$userIsSelectedField = 1');
    return res.isNotEmpty ? res.map((u) => UserModel.fromJson(u)).toList() : [];
  }

  Future<void> updateUser(UserModel user) async {
    Database db = await dbInstance.database;
    final id = user.toMap()[userIdField];
    await db.update(userTableName, user.toMap(), where: '$userIdField = ?', whereArgs: [id]);
  }

  Future<void> deleteUser(int id) async {
    Database db = await dbInstance.database;
    await db.delete(userTableName, where: '$userIdField = ?', whereArgs: [id]);
  }

  Future<int> updateUnselectedUser(int exceptedUserId) async {
    Database db = await dbInstance.database;
    final sql =
        'UPDATE $userTableName SET $userIsSelectedField = ? WHERE $userIdField != $exceptedUserId';
    return await db.rawUpdate(sql, [0]);
  }
}
