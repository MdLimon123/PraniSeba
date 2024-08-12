import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/custom_app_bar.dart';
import 'package:prani_sheba/common/style_data.dart';
import 'package:prani_sheba/controller/income_list_controller.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/ExpenseAccountData.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/IncomeAccountData.dart';

class IncomeListScreen extends StatefulWidget {
  static const routeName = 'income_list';
  final bool accountStatus;
  IncomeListScreen({
    this.accountStatus = true,
  });
  _ReportPregnant createState() => _ReportPregnant();
}

class _ReportPregnant extends State<IncomeListScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final IncomeListController incomeListController =
      Get.put(IncomeListController());
  String? selectedFarms, selectedIncomeAccountName, selectedFarmsId;
  String _dateBirthDay = '';
  String _dateLastDay = '';

  @override
  void dispose() {
    incomeListController.incomeList.data!.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: CustomAppBar(title: 'আয়ের তালিকা'),
      body: Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
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
                            "খামারের নাম‌",
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
                  Container(
                    margin: EdgeInsets.only(top: 2, left: 15, right: 12),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            'হিসাবের নাম',
                            textAlign: TextAlign.start,
                            style: TextStyle(color: Colors.grey, fontSize: 16),
                          ),
                        ),
                        Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<String>(
                              hint: Text("নির্বাচন করুন"),
                              value: selectedIncomeAccountName,
                              isDense: true,
                              onChanged: (String? newValue) {
                                setState(() {
                                  selectedIncomeAccountName = newValue;
                                });
                                print(selectedIncomeAccountName);
                              },
                              items: widget.accountStatus
                                  ? incomeAccountToList
                                      !.map((IncomeAccountData map) {
                                      return DropdownMenuItem<String>(
                                          value: map.id.toString(),
                                          child: Container(
                                            margin: EdgeInsets.only(left: 10),
                                            child: SizedBox(
                                              width: 80.0, // for example
                                              child: Text(map.name!,
                                                  textAlign: TextAlign.right),
                                            ),
                                          ));
                                    }).toList()
                                  : expenseAccountToList
                                      !.map((ExpenseAccountData map) {
                                      return DropdownMenuItem<String>(
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
                        ),
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
                  customButtonSearch(
                    onTap: () {
                      setCattleData();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 7,
              child: Obx(
                () {
                  if (incomeListController.isLoading.isTrue) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else {
                    if (incomeListController.incomeList.data!.isEmpty) {
                      return Center(
                        child: Text(
                            'কোন ${widget.accountStatus ? 'আয়' : 'ব্যয়'} পাওয়া যায়নি'),
                      );
                    } else {
                      return SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              RichText(
                                text: TextSpan(children: [
                                  TextSpan(
                                    text: 'মোট পরিমাণ: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: incomeListController
                                        .incomeList.totalQuantity
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
                                    text: 'মোট টাকা: ',
                                    style: TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                  TextSpan(
                                    text: incomeListController
                                        .incomeList.totalAmount
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
                                shrinkWrap: true,
                                physics: ScrollPhysics(),
                                itemCount: incomeListController
                                        .incomeList.data!.length ??
                                    0,
                                itemBuilder: (context, int index) {
                                  return Card(
                                    margin: EdgeInsets.zero,
                                    child: ListTile(
                                      title: RichText(
                                        text: TextSpan(children: [
                                          TextSpan(
                                              text: 'পরিমাণ: ',
                                              style: TextStyle(
                                                color: Colors.black,
                                              )),
                                          TextSpan(
                                              text: double.parse(
                                                      incomeListController
                                                          .incomeList
                                                          .data![index]
                                                          .quantity.toString())
                                                  .round()
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              )),
                                          TextSpan(
                                            text: ' x ',
                                            style: TextStyle(
                                              color: Colors.black,
                                            ),
                                          ),
                                          TextSpan(
                                              text: '৳' +
                                                  double.parse(
                                                          incomeListController
                                                              .incomeList
                                                              .data![index]
                                                              .amountPerUnit.toString())
                                                      .round()
                                                      .toString(),
                                              style: TextStyle(
                                                color: Colors.black,
                                              )),
                                        ]),
                                      ),
                                      subtitle: Text(
                                        'তারিখ: ' +
                                            DateFormat("yyyy-MM-dd").format(
                                              incomeListController
                                                  .incomeList.data![index].date!,
                                            ),
                                      ),
                                      trailing: Text(
                                          'মোট: ৳${double.parse(incomeListController.incomeList.data![index].totalAmount.toString()).round()}'),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
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
    } else if (selectedIncomeAccountName == null) {
      Common.setWrongToast('হিসাবের নাম');
    } else if (_dateBirthDay == '') {
      Common.setWrongToast('শুরুর তারিখ');
    } else if (_dateLastDay == '') {
      Common.setWrongToast('শেষ তারিখ');
    } else {
      incomeListController.fetchIncomeList(
        farmID: selectedFarmsId!,
        type: widget.accountStatus ? 'Income' : 'Expense',
        accId: selectedIncomeAccountName!,
        startDate: _dateBirthDay,
        endDate: _dateLastDay,
      );
    }
  }
}
