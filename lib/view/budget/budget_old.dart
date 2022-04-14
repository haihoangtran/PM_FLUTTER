// import 'package:flutter/material.dart';
// import 'package:pm_flutter/view/budget/budget_body.dart';
// import 'package:pm_flutter/view/budget/budget_top_bar.dart';

// class Budget extends StatefulWidget {
//   final int userId;

//   Budget({Key? key, required this.userId}) : super(key: key);

//   @override
//   _BudgetState createState() => _BudgetState(userId);
// }

// class _BudgetState extends State<Budget> {
//   int userId;


//   _BudgetState(this.userId);

//   @override
//   void initState() {
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               flex: 1,
//               child: Container(
//                 child: BudgetTopBar(),
//               ),
//             ),
//             Expanded(
//                 flex: 9,
//                 child: Container(
//                   child: BudgetBody(
//                     userId: userId,
//                   ),
//                 )),
//           ],
//         ),
//       ),
//     );
//   }
// }
