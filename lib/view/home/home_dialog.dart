import 'package:flutter/material.dart';
import 'package:pm_flutter/database/card_db.dart';
import 'package:pm_flutter/database/pm_db.dart';
import 'package:pm_flutter/database/user_db.dart';
import 'package:pm_flutter/model/card_model.dart';
import 'package:pm_flutter/model/user_model.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:pm_flutter/resources/app_strings.dart';
import 'package:pm_flutter/resources/colors/home_colors.dart';
import 'package:pm_flutter/resources/styles/home_styles.dart';
import 'package:pm_flutter/route.dart' as route;

class HomeDialog {
  final userDB = UsersDB(PMDatabase.instance);

  // Add/ Edit User dialog
  void buildAddEditUserDialog(BuildContext context, {bool isNew = true, UserModel? currentUser}) {
    String _username = (isNew ? '' : currentUser?.username)!;
    String _balance = (isNew ? '' : currentUser?.getBalance.toStringAsFixed(2))!;
    final userDB = UsersDB(PMDatabase.instance);
    List<DialogButton> dialogButtons = [
      DialogButton(
          child: Text(
            AppStrings.cancelText.toUpperCase(),
            style: HomeStyles.dialogButtonText,
          ),
          color: HomeColors.dialogBtn,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop()),
      DialogButton(
          child: Text(
            isNew ? AppStrings.addText.toUpperCase() : AppStrings.editText.toUpperCase(),
            style: HomeStyles.dialogButtonText,
          ),
          color: HomeColors.dialogBtn,
          onPressed: () {
            UserModel newUser =
                UserModel(isNew ? -1 : currentUser!.id, _username, double.parse(_balance), 1);
            if (isNew) {
              userDB.updateUnselectedUser(-1);
              userDB.addUser(newUser);
            } else {
              userDB.updateUser(newUser);
            }
            _refreshHomePage(context);
          })
    ];
    if (!isNew) {
      dialogButtons.add(DialogButton(
        child: Text(
          AppStrings.deleteText.toUpperCase(),
          style: HomeStyles.dialogButtonText,
        ),
        color: HomeColors.dialogDeleteBtn,
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          buildConfirmationDialog(context, () {
            userDB.deleteUser(currentUser!.id);
            _refreshHomePage(context);
          });
        },
      ));
    }
    Alert(
            context: context,
            title: isNew ? AppStrings.homeMenuAddUser : AppStrings.editUserDialogTitle,
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.account_circle),
                    labelText: AppStrings.userDialogUsernameLabel,
                  ),
                  controller: TextEditingController()..text = _username,
                  onChanged: (username) {
                    _username = username;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_balance),
                      labelText: AppStrings.userDialogBalanceLabel),
                  keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                  controller: TextEditingController()..text = _balance,
                  onChanged: (balance) {
                    _balance = balance;
                  },
                )
              ],
            ),
            buttons: dialogButtons)
        .show();
  }

  // Select User Dialog
  Future<dynamic> buildSelectUserDialog(BuildContext context) async {
    final allUsers = await userDB.getAllUsers();
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(AppStrings.selectUserTitle),
            content: Container(
              width: double.minPositive,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: allUsers.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    title: Text(allUsers[index].username),
                    selectedColor: allUsers[index].isSelected == 1 ? Colors.cyan : null,
                    onTap: () {
                      final selectedUser = allUsers[index];
                      selectedUser.isSelected = 1;
                      userDB.updateUnselectedUser(-1);
                      userDB.updateUser(selectedUser);
                      _refreshHomePage(context);
                    },
                  );
                },
              ),
            ),
          );
        });
  }

  // Add / Edit Card Dialog
  // @param isNew: true => set value for userID
  //        false => set value for updatedCard
  void buildAddEditCardDialog(BuildContext context,
      {bool isNew = true, int? userID, CardModel? updatedCard}) {
    String _cardName = (isNew ? '' : updatedCard?.cardName)!;
    String _balance = (isNew ? '' : updatedCard?.getBalance.toStringAsFixed(2))!;
    final cardDB = CardsDB(PMDatabase.instance);
    List<DialogButton> dialogButtons = [
      DialogButton(
          child: Text(
            AppStrings.cancelText.toUpperCase(),
            style: HomeStyles.dialogButtonText,
          ),
          color: HomeColors.dialogBtn,
          onPressed: () => Navigator.of(context, rootNavigator: true).pop()),
      DialogButton(
          child: Text(
            isNew ? AppStrings.addText.toUpperCase() : AppStrings.editText.toUpperCase(),
            style: HomeStyles.dialogButtonText,
          ),
          color: HomeColors.dialogBtn,
          onPressed: () {
            CardModel newCard = CardModel(isNew ? -1 : updatedCard!.id, _cardName,
                double.parse(_balance), isNew ? userID! : updatedCard!.userId);
            if (isNew) {
              cardDB.addCard(newCard);
            } else {
              cardDB.updateCard(newCard);
            }
            _refreshHomePage(context);
          })
    ];
    if (!isNew) {
      dialogButtons.add(DialogButton(
        child: Text(
          AppStrings.deleteText.toUpperCase(),
          style: HomeStyles.dialogButtonText,
        ),
        color: HomeColors.dialogDeleteBtn,
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop();
          buildConfirmationDialog(context, () {
            cardDB.deleteCard(updatedCard!.id);
            _refreshHomePage(context);
          });
        },
      ));
    }
    Alert(
            context: context,
            title: isNew ? AppStrings.homeMenuAddCard : AppStrings.editCardDialogTitle,
            content: Column(
              children: <Widget>[
                TextField(
                  decoration: InputDecoration(
                    icon: Icon(Icons.credit_card_rounded),
                    labelText: AppStrings.cardDialogCardNameLabel,
                  ),
                  controller: TextEditingController()..text = _cardName,
                  onChanged: (cardName) {
                    _cardName = cardName;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                      icon: Icon(Icons.account_balance),
                      labelText: AppStrings.cardDialogCardBalanceLabel),
                  keyboardType: TextInputType.numberWithOptions(decimal: true, signed: true),
                  controller: TextEditingController()..text = _balance,
                  onChanged: (balance) {
                    _balance = balance;
                  },
                )
              ],
            ),
            buttons: dialogButtons)
        .show();
  }

  void buildConfirmationDialog(BuildContext context, VoidCallback confirmFunction) {
    Alert(
        context: context,
        title: AppStrings.confirmationDialogTitle,
        desc: AppStrings.confirmationDialogMessage,
        buttons: [
          DialogButton(
              child: Text(
                AppStrings.noText,
                style: HomeStyles.dialogButtonText,
              ),
              color: HomeColors.dialogBtn,
              onPressed: () => Navigator.of(context, rootNavigator: true).pop()),
          DialogButton(
              child: Text(
                AppStrings.yesText,
                style: HomeStyles.dialogButtonText,
              ),
              color: Colors.red,
              onPressed: confirmFunction)
        ]).show();
  }

  void _refreshHomePage(BuildContext context) {
    Navigator.pop(context);
    Navigator.popAndPushNamed(context, route.homePage);
  }
}
