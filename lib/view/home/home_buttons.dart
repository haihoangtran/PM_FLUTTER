import 'package:flutter/material.dart';
import 'package:pm_flutter/resources/colors/home_colors.dart';
import 'package:pm_flutter/resources/app_strings.dart';
import '../common/size_box.dart';
import 'package:pm_flutter/route.dart' as route;

class HomeButtons extends StatelessWidget {
  final int userId;

  HomeButtons(this.userId);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buttonWidget(context, AppStrings.budgetLabel, 'lib/resources/images/budget_icon.png',
                  () => Navigator.pushNamed(context, route.budgetPage, arguments: userId))
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _buttonWidget(
                  context, AppStrings.paymentLabel, 'lib/resources/images/payment_icon.png', () {}),
              _buttonWidget(
                  context, AppStrings.noteLabel, 'lib/resources/images/note_icon.png', () {})
            ],
          )
        ]));
  }

  Widget _buttonWidget(
      BuildContext context, String buttonLabel, String iconImagePath, VoidCallback onTapFunc) {
    return GestureDetector(
      onTap: onTapFunc,
      child: Card(
        color: HomeColors.cardTypeBackground,
        shape: CircleBorder(
            side: BorderSide(
          color: HomeColors.cardBorder,
        )),
        child: Container(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width / 2.5,
            minHeight: MediaQuery.of(context).size.width / 2.5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                iconImagePath,
                height: 50,
                width: 50,
              ),
              SizeBox.verticalBox2(),
              Text(buttonLabel.toUpperCase())
            ],
          ),
        ),
      ),
    );
  }
}
