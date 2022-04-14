import 'package:flutter/material.dart';
import 'package:pm_flutter/model/user_model.dart';
import 'package:pm_flutter/resources/colors/home_colors.dart';
import 'package:pm_flutter/resources/styles/home_styles.dart';
import 'package:pm_flutter/resources/app_strings.dart';
import 'home_dialog.dart';

// ignore: must_be_immutable
class HomeTopBar extends StatelessWidget {
  UserModel? currentUser;

  HomeTopBar(this.currentUser);

  Widget _userAvatarWidget() {
    return Container(
        child: Image.asset(
      'lib/resources/images/user_avatar.png',
      height: 80,
      width: 80,
    ));
  }

  Widget _userInformationWidget(BuildContext context) {
    return GestureDetector(
      onTap: () {
        HomeDialog().buildAddEditUserDialog(context, isNew: false, currentUser: currentUser);
      },
      child: Container(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            currentUser?.username ?? '',
            style: HomeStyles.usernameText,
          ),
          Text(
            currentUser?.getBalance.toStringAsFixed(2) ?? '',
            style: HomeStyles.balanceText,
          )
        ],
      )),
    );
  }

  Widget _iconButtonsWidget(BuildContext context) {
    List<String> _menuItems = [
      AppStrings.homeMenuAddUser,
      AppStrings.homeMenuSwitchUser,
      AppStrings.homeMenuAddCard,
      AppStrings.homeMenuShare
    ];
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IconButton(
              key: Key('add_new_budget'),
              onPressed: null,
              icon: Icon(
                Icons.add,
                color: HomeColors.topBarIcon,
              )),
          PopupMenuButton(
            child: IconButton(
                key: Key('more'),
                onPressed: null,
                icon: Icon(
                  Icons.more_vert,
                  color: HomeColors.topBarIcon,
                )),
            itemBuilder: (context) {
              return _menuItems.map((item) {
                return PopupMenuItem(value: item, child: Text(item));
              }).toList();
            },
            onSelected: (item) {
              switch (item) {
                case AppStrings.homeMenuAddUser:
                  HomeDialog().buildAddEditUserDialog(context);
                  break;
                case AppStrings.homeMenuSwitchUser:
                  HomeDialog().buildSelectUserDialog(context);
                  break;
                case AppStrings.homeMenuAddCard:
                  HomeDialog().buildAddEditCardDialog(context, isNew: true, userID: currentUser?.id);
                  break;
                default:
                  print(item);
                  break;
              }
            },
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(5, 0, 5, 10),
      child: Container(
          child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 1, child: _userAvatarWidget()),
          Expanded(flex: 4, child: _userInformationWidget(context)),
          Expanded(flex: 2, child: _iconButtonsWidget(context))
        ],
      )),
    );
  }
}
