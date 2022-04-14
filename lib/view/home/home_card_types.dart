import 'package:flutter/material.dart';
import 'package:pm_flutter/database/card_db.dart';
import 'package:pm_flutter/database/pm_db.dart';
import 'package:pm_flutter/model/card_model.dart';
import 'package:pm_flutter/resources/colors/home_colors.dart';
import 'package:pm_flutter/resources/app_strings.dart';
import 'package:pm_flutter/resources/styles/home_styles.dart';
import './home_dialog.dart';
import '../common/size_box.dart';

// ignore: must_be_immutable
class HomeCardTypes extends StatelessWidget {
  final cardDB = CardsDB(PMDatabase.instance);
  int userId = -1;

  HomeCardTypes(userId) {
    this.userId = userId;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: cardDB.getAllCards(userId),
        builder: (BuildContext context, AsyncSnapshot<List<CardModel>> snapshot) {
          if (snapshot.hasData) {
            var cards = snapshot.data!;
            return Padding(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                child: Card(
                    color: HomeColors.cardTypeBackground,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(color: HomeColors.cardBorder),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                        minHeight: 80,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(15),
                        child: SingleChildScrollView(
                          child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    children: [
                                      for (var card in cards)
                                        GestureDetector(
                                          onTap: () {
                                            HomeDialog().buildAddEditCardDialog(context,
                                                isNew: false, updatedCard: card);
                                          },
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              Row(children: [
                                                Text(
                                                  AppStrings.circleBullet,
                                                  style: HomeStyles.cardText,
                                                ),
                                                SizeBox.horizontalBox1(),
                                                Text(
                                                  card.cardName,
                                                  style: HomeStyles.cardText,
                                                )
                                              ]),
                                              Row(
                                                children: [
                                                  Text(
                                                    card.getBalance.toStringAsFixed(2),
                                                    style: HomeStyles.cardBalanceText,
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                    ],
                                  ),
                          ),
                      ),
                    )));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}
