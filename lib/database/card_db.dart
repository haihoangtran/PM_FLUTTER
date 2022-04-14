import 'package:pm_flutter/database/pm_db.dart';
import 'package:pm_flutter/model/card_model.dart';
import 'package:sqflite/sqflite.dart';

import 'package:pm_flutter/resources/const/db_const.dart';

class CardsDB {
  late PMDatabase dbInstance;

  CardsDB(this.dbInstance);

  Future<void> addCard(CardModel card) async {
    Database db = await dbInstance.database;
    await db.insert(cardsTableName, {
      cardsNameField: card.cardName,
      cardBalanceField: card.balance,
      cardUserIdField: card.userId
    });
  }

  Future<List<CardModel>> getAllCards(int userID) async {
    Database db = await dbInstance.database;
    var res = await db.query(cardsTableName, where: '$cardUserIdField = ?', whereArgs: [userID]);
    return res.isNotEmpty ? res.map((c) => CardModel.fromJson(c)).toList() : [];
  }

  Future<void> updateCard(CardModel card) async {
    Database db = await dbInstance.database;
    final id = card.toMap()[cardsIdField];
    await db.update(cardsTableName, card.toMap(), where: '$cardsIdField = ?', whereArgs: [id]);
  }

  Future<void> deleteCard(int cardId) async {
    Database db = await dbInstance.database;
    await db.delete(cardsTableName, where: '$cardsIdField = ?', whereArgs: [cardId]);
  }
}
