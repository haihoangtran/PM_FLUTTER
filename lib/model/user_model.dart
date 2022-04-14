import 'package:pm_flutter/resources/const/db_const.dart';

class UserModel {
  int id;
  String username;
  double balance;
  int isSelected; // selected => 1, unselected => 0

  UserModel(this.id, this.username, this.balance, this.isSelected);

  double get getBalance {
    return double.parse(balance.toStringAsFixed(2));
  }

  factory UserModel.fromJson(Map<String, dynamic> map) =>
      UserModel(map[userIdField], map[userNameField], map[userBalanceField], map[userIsSelectedField]);

  Map<String, dynamic> toMap() => {
        userIdField: id,
        userNameField: username,
        userBalanceField: balance,
        userIsSelectedField: isSelected
      };
}
