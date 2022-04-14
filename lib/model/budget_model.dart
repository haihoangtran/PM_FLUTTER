import 'package:intl/intl.dart';
import 'package:pm_flutter/resources/const/db_const.dart';

class BudgetsModel {
  late int id;
  late String place;
  late double amount;
  late String date;
  late int type; // deposit => 1, withdraw => 0
  late int userId;
  late int cardId;

  BudgetsModel(id, place, amount, date, type, userId, cardId) {
    this.id = id;
    this.place = place;
    this.amount = amount;
    this.date = DateFormat('yyyy-MM-dd').format(date);
    this.type = type;
    this.userId = userId;
    this.cardId = cardId;
  }

  double get getAmount {
    return double.parse(amount.toStringAsFixed(2));
  }

  String get getDate {
    return DateFormat('MM/dd/yyyy').format(DateTime.parse(date));
  }

  factory BudgetsModel.fromJson(Map<String, dynamic> map) => BudgetsModel(
      map[budgetsIdField],
      map[budgetsPlaceField],
      map[budgetsAmountField],
      map[budgetsDateField],
      map[budgetsTypeField],
      map[budgetsUserIdField],
      map[budgetsCardIdField]);

  Map<String, dynamic> toMap() => {
        budgetsIdField: id,
        budgetsPlaceField: place,
        budgetsAmountField: amount,
        budgetsDateField: date,
        budgetsTypeField: type,
        budgetsUserIdField: userId,
        budgetsCardIdField: cardId
      };
}
