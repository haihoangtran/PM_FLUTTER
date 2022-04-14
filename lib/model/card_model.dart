import 'package:pm_flutter/resources/const/db_const.dart';

class CardModel {
  int id;
  String cardName;
  double balance;
  int userId; 

  CardModel(this.id, this.cardName, this.balance, this.userId);

  double get getBalance {
    return double.parse(balance.toStringAsFixed(2));
  }

  factory CardModel.fromJson(Map<String, dynamic> map) =>
      CardModel(map[cardsIdField], map[cardsNameField], map[cardBalanceField], map[cardUserIdField]);

  Map<String, dynamic> toMap() => {
        cardsIdField: id,
        cardsNameField: cardName,
        cardBalanceField: balance,
        cardUserIdField: userId
      };
}