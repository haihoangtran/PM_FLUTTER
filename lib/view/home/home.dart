import 'package:flutter/material.dart';
import 'package:pm_flutter/database/pm_db.dart';
import 'package:pm_flutter/database/user_db.dart';
import 'package:pm_flutter/view/home/home_dialog.dart';
import './home_top_bar.dart';
import './home_card_types.dart';
import './home_buttons.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final userDB = UsersDB(PMDatabase.instance);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: Future.wait([userDB.getSelectedUser(), userDB.getAllUsers()]),
        builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            var selectedUsers = snapshot.data![0];
            var allUsers = snapshot.data![1];
            if (selectedUsers.isEmpty) {
              if (allUsers.isEmpty) {
                Future.delayed(
                    Duration.zero, () => HomeDialog().buildAddEditUserDialog(context));
              } else {
                Future.delayed(
                    Duration.zero, () => HomeDialog().buildSelectUserDialog(context));
              }
            }
            return SafeArea(
              child: Column(
                children: [
                  Expanded(
                      flex: 1,
                      child: HomeTopBar(selectedUsers.isEmpty ? null : selectedUsers.first)),
                  Expanded(flex: 1, child: HomeCardTypes(selectedUsers.isEmpty ? -1 : selectedUsers.first.id)),
                  Expanded(flex: 4, child: HomeButtons(selectedUsers.isEmpty ? -1 : selectedUsers.first.id)),
                ],
              ),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
