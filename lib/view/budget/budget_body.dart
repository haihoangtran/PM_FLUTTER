import 'package:flutter/material.dart';
import 'package:pm_flutter/database/card_db.dart';
import 'package:pm_flutter/database/pm_db.dart';
import 'package:pm_flutter/model/card_model.dart';
import 'package:pm_flutter/resources/colors/budget_colors.dart';
import 'package:pm_flutter/resources/styles/budget_styles.dart';

class BudgetBody extends StatefulWidget {
  final userId;

  BudgetBody({Key? key, this.userId}) : super(key: key);

  @override
  _BudgetBodyState createState() => _BudgetBodyState(userId);
}

class _BudgetBodyState extends State<BudgetBody> {
  int userId;
  final cardDB = CardsDB(PMDatabase.instance);
  int _selectedIndex = 0;
  List<CardModel> cardModels = [];

  List<String> monthDropdownItems = ['Jan', 'Feb', 'Mar', 'Apr', 'May'];
  List<String> yearDropdownItems = ['2021', '2022', '2023'];
  String currentMonth = 'Jan';
  String currentYear = '2022';

  _BudgetBodyState(this.userId);

  void initState() {
    super.initState();
    cardDB.getAllCards(userId).then((value) {
      setState(() {
        cardModels = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<BottomNavigationBarItem> bottomNavItems = [];
    for (final card in cardModels) {
      bottomNavItems.add(BottomNavigationBarItem(
        icon: Icon(
          Icons.credit_card,
          color: BudgetColors
              .creditCardIcons[cardModels.indexOf(card) % BudgetColors.creditCardIcons.length],
        ),
        label: card.cardName,
      ));
    }

    // Fake records
    List<List<String>> records = [];
    for (int i = 0; i < (_selectedIndex == 0 ? 30 : 5); i++) {
      records.add(['place $i', '02/16/2022', (26.35 + i).toString()]);
    }

    if (cardModels.isEmpty) {
      return Center(child: CircularProgressIndicator());
    } else {
      return Scaffold(
        body: Padding(
          padding: EdgeInsets.fromLTRB(10, 0, 10, 10),
          child: Container(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Dropdown buttons
              Expanded(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, 5, 0),
                              child: Container(
                                padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                decoration: BoxDecoration(
                                    color: BudgetColors.dropdownBackgroundBtn,
                                    borderRadius: BorderRadius.circular(30)),
                                child: DropdownButton<String>(
                                    value: currentMonth,
                                    icon: const Icon(Icons.arrow_drop_down),
                                    underline: Container(),
                                    isExpanded: true,
                                    items: monthDropdownItems
                                        .map<DropdownMenuItem<String>>((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        currentMonth = newValue!;
                                      });
                                    }),
                              ),
                            )),
                        Expanded(
                            flex: 1,
                            child: Padding(
                              padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                              child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                                  decoration: BoxDecoration(
                                      color: BudgetColors.dropdownBackgroundBtn,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: DropdownButton<String>(
                                      value: currentYear,
                                      icon: const Icon(Icons.arrow_drop_down),
                                      underline: Container(),
                                      isExpanded: true,
                                      items: yearDropdownItems
                                          .map<DropdownMenuItem<String>>((String value) {
                                        return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value),
                                        );
                                      }).toList(),
                                      onChanged: (String? newValue) {
                                        setState(() {
                                          currentYear = newValue!;
                                        });
                                      })),
                            )),
                      ],
                    ),
                  )),
              // Budget Records List
              Expanded(
                  flex: 8,
                  child: Padding(
                    padding: EdgeInsets.fromLTRB(0, 5, 0, 0),
                    child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: records.length,
                        itemBuilder: (context, index) {
                          var record = records[index];
                          return Card(
                              color: BudgetColors.recordBackground,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(15.0))),
                              child: Padding(
                                padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: [
                                        Text(
                                          record[0],
                                          style: BudgetStyles.recordPlaceTextStyle,
                                        ),
                                        Text(
                                          record[1],
                                          style: BudgetStyles.recordDateTextStyle,
                                        ),
                                      ],
                                    ),
                                    Text(
                                      record[2],
                                      style: BudgetStyles.recordAmoundTextStyle(
                                          BudgetColors.depositBalance),
                                    )
                                  ],
                                ),
                              ));
                        }),
                    // child: ClipRRect(
                    //     borderRadius: BorderRadius.all(Radius.circular(30)),
                    //     child: Container(
                    //       color: BudgetColors.recordBackground,
                    //       child: Padding(
                    //         padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                    //         child: Container(
                    //           color: Colors.blue,
                    //         ),
                    //       ),
                    //     )),
                  ))
            ],
          )),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(color: Colors.black45, spreadRadius: 1, blurRadius: 10),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            child: BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              backgroundColor: BudgetColors.bottomNavBackground,
              unselectedLabelStyle: BudgetStyles.bottomNavUnselectedTextStyle,
              selectedLabelStyle: BudgetStyles.bottomNavSelectedTextStyle,
              showUnselectedLabels: true,
              items: bottomNavItems,
              currentIndex: _selectedIndex,
              selectedItemColor: BudgetColors.bottomNavSelectedItem,
              onTap: (int index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
            ),
          ),
        ),
      );
    }
  }
}
