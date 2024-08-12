import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/custom_app_bar.dart';
import 'package:prani_sheba/common/style_data.dart';
import 'package:prani_sheba/controller/account_history_controller.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/FarmsData.dart';

class ListOfAccountsScreen extends StatefulWidget {
  static const routeName = 'list_of_account';

  _ReportPregnant createState() => _ReportPregnant();
}

class _ReportPregnant extends State<ListOfAccountsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final AccountHistoryController accountHistoryController =
      Get.put(AccountHistoryController());
  String? selectedFarms, selectedFarmsId;
  String _dateBirthDay = '';
  String _dateLastDay = '';

  @override
  void dispose() {
    accountHistoryController.accountHistory.data!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: CustomAppBar(title: 'হিসাবের তালিকা'),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 2, left: 15, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          child: Text(
                            "ফার্মের নাম‌",
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text("নির্বাচন করুন"),
                              value: selectedFarms,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedFarms = newValue;
                                });
                                print(selectedFarms);
                              },
                              items: farmsToList!.map((FarmsData map) {
                                return DropdownMenuItem<String>(
                                    onTap: () {
                                      setState(() {
                                        selectedFarmsId = map.id.toString();
                                      });
                                      print(selectedFarmsId);
                                    },
                                    value: map.id.toString(),
                                    child: Container(
                                      margin: EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                        width: 80.0, // for example
                                        child: Text(map.name!,
                                            textAlign: TextAlign.right),
                                      ),
                                    ));
                              }).toList(),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 0, left: 15, right: 12),
                      child: Divider()),
                  size15,
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            _dateBirthDay =
                                await selectDate(context, date: _dateBirthDay);
                            setState(() {});
                          },
                          child: Column(
                            children: [
                              Text('শুরুর তারিখ (yyyy-MM-dd)',
                                  style: TextStyle(
                                      fontSize: 12.5, color: Colors.grey)),
                              Row(
                                children: [
                                  Expanded(
                                      child: Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text(_dateBirthDay),
                                  )),
                                  Icon(Icons.calendar_today_outlined,
                                      color: Colors.grey, size: 18),
                                ],
                              ),
                              SizedBox(height: 2),
                              Container(
                                height: 1,
                                margin: EdgeInsets.only(left: 20),
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                      width10,
                      Expanded(
                        child: InkWell(
                          onTap: () async {
                            _dateLastDay =
                                await selectDate(context, date: _dateLastDay);
                            setState(() {});
                          },
                          child: Column(
                            crossAxisAlignment: crossAxisStart,
                            children: [
                              Text(
                                'শেষ তারিখ (yyyy-MM-dd)',
                                style: TextStyle(
                                    fontSize: 12.5, color: Colors.grey),
                              ),
                              Row(
                                children: [
                                  Expanded(child: Text(_dateLastDay)),
                                  Icon(Icons.calendar_today_outlined,
                                      color: Colors.grey, size: 20),
                                  SizedBox(width: 20),
                                ],
                              ),
                              SizedBox(height: 2),
                              Container(
                                height: 1,
                                margin: EdgeInsets.only(right: 20),
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  customButtonSearch(onTap: () {
                    setCattleData();
                  }),
                  //List view show
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: Obx(
                () {
                  if (accountHistoryController.isLoading.isTrue) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (accountHistoryController.accountHistory.data!.isEmpty) {
                      return Center(
                        child: Text('কোন হিসাবের তালিকা পাওয়া যায়নি'),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'মোট আয়: ৳',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: accountHistoryController
                                      .accountHistory.totalIncome
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'মোট ব্যয়: ৳',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: accountHistoryController
                                      .accountHistory.totalExpense
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: 'ব্যালান্স: ৳',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: accountHistoryController
                                      .accountHistory.balance
                                      .toString(),
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ]),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            ListView.builder(
                              physics: ScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: accountHistoryController
                                  .accountHistory.data!.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  margin: EdgeInsets.zero,
                                  child: ExpansionTile(
                                    backgroundColor:
                                        Colors.green.withOpacity(.2),
                                    title: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          child: SelectableText(
                                            'তারিখ: ' +
                                                DateFormat("yyyy-MM-dd").format(
                                                  accountHistoryController
                                                      .accountHistory
                                                      .data![index]
                                                      .date!,
                                                ),
                                            style: TextStyle(
                                                color: Colors.green,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            'ব্যালান্স: ৳' +
                                                accountHistoryController
                                                    .accountHistory
                                                    .data![index]
                                                    .balance
                                                    .toString(),
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontWeight: FontWeight.w600),
                                          ),
                                        ),
                                      ],
                                    ),
                                    children: [
                                      for (int index2 = 0;
                                          index2 <
                                              accountHistoryController
                                                  .accountHistory
                                                  .data![index]
                                                  .entries!
                                                  .length;
                                          index2++)
                                        Card(
                                          child: ListTile(
                                            title: Text(
                                              accountHistoryController
                                                  .accountHistory
                                                  .data![index]
                                                  .entries![index2]
                                                  .name.toString(),
                                            ),
                                            subtitle: Text(
                                              'পরিমাণ: ${double.parse(accountHistoryController.accountHistory.data![index].entries![index2].quantity.toString()).round().toString()} ${accountHistoryController.accountHistory.data![index].entries![index2].unit} x ৳${double.parse(accountHistoryController.accountHistory.data![index].entries![index2].amountPerUnit.toString()).round()}',
                                            ),
                                            trailing: Text(
                                              'মোট: ৳${double.parse(accountHistoryController.accountHistory.data![index].entries![index2].totalAmount.toString()).round()}',
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setCattleData() {
    if (selectedFarms == null) {
      Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
    } else if (_dateBirthDay == '') {
      Common.setWrongToast('শুরুর তারিখ');
    } else if (_dateLastDay == '') {
      Common.setWrongToast('শেষ তারিখ');
    } else {
      accountHistoryController.fetchAccountHistory(
        farmID: selectedFarmsId!,
        startDate: _dateBirthDay,
        endDate: _dateLastDay,
      );
    }
  }
}
