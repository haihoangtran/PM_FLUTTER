import 'package:flutter/material.dart';
import 'view/budget/budget.dart';
import 'view/home/home.dart';

const String homePage = '/home';
const String budgetPage = '/budget';

Route<dynamic> controller(RouteSettings settings) {
  switch (settings.name) {
    case homePage:
      return new MaterialPageRoute(builder: (context) => new Home());
    case budgetPage:
      return new MaterialPageRoute(builder: (context) => new Budget(userId: settings.arguments as int,));
    default:
      throw ("This route name is not existed");
  }
}
