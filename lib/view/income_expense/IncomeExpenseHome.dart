import 'package:flutter/material.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/view/MyApp2.dart';
import 'package:prani_sheba/view/income_expense/NewIncomeExprense.dart';
import 'package:prani_sheba/view/income_expense/income_list_screen.dart';
import 'package:prani_sheba/view/income_expense/list_of_accounts_screen.dart';

class IncomeExpenseHome extends StatelessWidget {
  static const routeName = 'income_expense_home';

  @override
  Widget build(BuildContext context) {
    const List<Choice> choices = const <Choice>[
      const Choice(title: 'নতুন আয় ব্যায়', icon: "assets/images/income_ex.png"),
      const Choice(
          title: 'হিসাবের তালিকা', icon: "assets/images/account_list.png"),
      const Choice(title: 'আয়ের তালিকা', icon: "assets/images/income_list.png"),
      const Choice(title: 'ব্যায়ের তালিকা', icon: "assets/images/ex_list.png"),
    ];

    return Scaffold(
      appBar: AppBar(
        // you can put Icon as well, it accepts any widget.
        //title: Text ("Your Title"),
        backgroundColor: Color(Helper.getHexToInt(CommonColor.primaryColor)),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text('আয় ব্যায়'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 20.0),
                child: Image.asset(
                  'assets/images/logo.png',
                  width: 150,
                  height: 150,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 55, left: 12, right: 12, bottom: 10),
              child: GridView.count(
                  shrinkWrap: true,
                  physics: ScrollPhysics(),
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 8.0,
                  children: List.generate(choices.length, (index) {
                    return Center(
                      child: GestureDetector(
                        onTap: () {
                          openNewPage(index, context);
                        },
                        child: SelectCard(choice: choices[index]),
                      ),
                    );
                  })),
            )
          ],
        ),
      ),
    );
  }

  void openNewPage(int index, BuildContext context) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, NewIncomeExprense.routeName);
        break;

      case 1:
        Navigator.pushNamed(context, ListOfAccountsScreen.routeName);
        break;

      case 2:
        Navigator.pushNamed(context, IncomeListScreen.routeName);
        break;

      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => IncomeListScreen(
              accountStatus: false,
            ),
          ),
        );
        // Navigator.pushNamed(context, ExpenseListScreen.routeName);
        break;
    }
  }
}
