import 'package:flutter/material.dart';
import 'package:pm_flutter/resources/app_strings.dart';
import 'package:pm_flutter/resources/colors/budget_colors.dart';
import 'package:pm_flutter/resources/styles/budget_styles.dart';
import 'package:pm_flutter/view/budget/budget_body.dart';

class Budget extends StatefulWidget {
  final int userId;

  Budget({Key? key, required this.userId}) : super(key: key);

  @override
  _BudgetState createState() => _BudgetState(userId: userId);
}

class _BudgetState extends State<Budget> {
  late int userId;
  late List<String> _menuItems;

  _BudgetState({required userId}) {
    this.userId = userId;
    this._menuItems = [AppStrings.budgetMenuPayCard,
                       AppStrings.budgetMenuDeleteBudget,];
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                child: _buildTopBar(context),
              ),
            ),
            Expanded(
                flex: 9,
                child: Container(
                  child: BudgetBody(
                    userId: userId,
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
              flex: 1,
              child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back))),
          Expanded(
              flex: 4,
              child: Text(
                '3,2565.25',
                style: BudgetStyles.totalWithdrawText,
              )),
          Expanded(
            flex: 2,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.add,
                        color: BudgetColors.topBarIcon,
                      )),
                  PopupMenuButton(
                    child: IconButton(
                      key: Key('budge_more'),
                      onPressed: null,
                      icon: Icon(
                        Icons.more_vert,
                        color: BudgetColors.topBarIcon,
                      ),
                    ),
                    itemBuilder: (context) {
                      return _menuItems.map((item) {
                        return PopupMenuItem(value: item, child: Text(item));
                      }).toList();
                    },
                    onSelected: (item) {
                      switch (item) {
                        default:
                          print(item);
                          break;
                      }
                    },
                  )
                ]),
          ),
        ],
      )),
    );
  }
}
