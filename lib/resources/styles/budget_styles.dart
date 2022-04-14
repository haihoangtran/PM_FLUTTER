import 'package:flutter/material.dart';
import '../colors/budget_colors.dart';

class BudgetStyles {
  static const totalDepositText =
      TextStyle(color: BudgetColors.depositBalance, fontSize: 30.0, fontWeight: FontWeight.bold);
  static const totalWithdrawText =
      TextStyle(color: BudgetColors.withdrawBalance, fontSize: 30.0, fontWeight: FontWeight.bold);
  static const bottomNavUnselectedTextStyle =
      TextStyle(color: BudgetColors.bottomNavUnselectedLabel, fontSize: 14);
  static const bottomNavSelectedTextStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const recordPlaceTextStyle = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
  static const recordDateTextStyle = TextStyle(fontSize: 14);
  static recordAmoundTextStyle(Color color) => TextStyle(fontSize: 18, color: color);
}
