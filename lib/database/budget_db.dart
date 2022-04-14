import 'package:pm_flutter/database/pm_db.dart';
import 'package:pm_flutter/model/budget_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:pm_flutter/resources/const/db_const.dart';

class BudgetDB {
  late PMDatabase dbInstance;

  BudgetDB(this.dbInstance);

  Future<void> addNewBudget(BudgetsModel budget) async {
    Database db = await dbInstance.database;
    await db.insert(budgetsTableName, {
      budgetsPlaceField: budget.place,
      budgetsAmountField: budget.amount,
      budgetsDateField: budget.date,
      budgetsTypeField: budget.type,
      budgetsUserIdField: budget.userId,
      budgetsCardIdField: budget.cardId
    });
  }

  Future<List<BudgetsModel>> getMonthlyBudget(String month, String year) async {
    // Implement code here
    return [];
  }

  Future<void> updateBudget(BudgetsModel budget) async {
    Database db = await dbInstance.database;
    final id = budget.toMap()[budgetsIdField];
    await db
        .update(budgetsTableName, budget.toMap(), where: '$budgetsIdField = ?', whereArgs: [id]);
  }

  Future<void> deleteBudget(int budgetId) async {
    Database db = await dbInstance.database;
    await db.delete(budgetsTableName, where: '$budgetsIdField = ?', whereArgs: [budgetId]);
  }
}
