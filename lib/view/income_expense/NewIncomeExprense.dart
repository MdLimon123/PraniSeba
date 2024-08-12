import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:prani_sheba/Common/Helper.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/ExpenseAccountData.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/IncomeAccountData.dart';
import 'package:prani_sheba/services/NetworkServices.dart';
import 'package:prani_sheba/view/auth/Login_page.dart';
import 'package:prani_sheba/view/cow_registraton/CowRegistrationHome.dart';
import 'package:prani_sheba/widget/CustomDialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class NewIncomeExprense extends StatefulWidget {
  static const routeName = 'new_income_expense';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<NewIncomeExprense> {
  TextEditingController quantityCon = TextEditingController();
  TextEditingController unitIncomeExpense = TextEditingController();
  TextEditingController totalCon = TextEditingController();
  TextEditingController remarkCon = TextEditingController();
  List<String> _accountType = ['আয়', 'ব্যয়'];
  int? total;
  String? selectedFarms,
      selectedAccountType,
      selectedIncomeAccountName,
      quantity = '0',
      unitIncome = '0';
  bool accountStatus = false;
  bool accountVisibility = false;
  DateTime selectedDate = DateTime.now();
  TextEditingController _date = new TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2500));
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;

        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        String string = dateFormat.format(selectedDate);
        _date.value = TextEditingValue(text: string);
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(Helper.getHexToInt(CommonColor.primaryColor)),
        // you can put Icon as well, it accepts any widget.
        //title: Text ("Your Title"),
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            }),
        centerTitle: true,
        title: Text('নতুন আয় ব্যয়'),
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
                  height: 120,
                ),
              ),
            ),
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
                      'হিসাবের ধরণ',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedAccountType,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAccountType = newValue;
                          });
                          print(selectedAccountType);
                          if (selectedAccountType == 'আয়') {
                            accountStatus = true;
                            accountVisibility = true;
                          }
                          if (selectedAccountType == 'ব্যয়') {
                            accountStatus = false;
                            accountVisibility = true;
                          }
                        },
                        items: _accountType.map((location) {
                          return DropdownMenuItem(
                              value: location,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 80.0, // for example
                                  child: Text(location,
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
            Visibility(
              visible: accountVisibility,
              child: Container(
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
                          items: accountStatus
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
            ),
            Visibility(
              visible: accountVisibility,
              child: Container(
                  margin: EdgeInsets.only(top: 0, left: 15, right: 12),
                  child: Divider()),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: TextField(
                textAlign: TextAlign.start,
                controller: quantityCon,
                autofocus: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'পরিমাণ',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    quantity = newValue;
                  });
                  print(quantity);
                  int quan = int.parse(quantity!);
                  assert(quan is int);
                  int unit = int.parse(unitIncome!);
                  assert(unit is int);

                  total = (quan + unit);
                  totalCon.text = total.toString();
                  print(total);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: TextField(
                textAlign: TextAlign.start,
                controller: unitIncomeExpense,
                autofocus: false,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: 'প্রতি ইউনিট আয়/ব্যয়',
                  labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                ),
                onChanged: (String newValue) {
                  setState(() {
                    unitIncome = newValue;
                  });
                  print(unitIncome);
                  int quan = int.parse(quantity!);
                  assert(quan is int);
                  int unit = int.parse(unitIncome!);
                  assert(unit is int);

                  total = (quan + unit);
                  totalCon.text = total.toString();
                  print(total);
                },
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: TextField(
                  textAlign: TextAlign.start,
                  controller: totalCon,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'সর্বমোট',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
            ),
            Container(
              //_selectedLastDay
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: GestureDetector(
                  onTap: () {
                    _selectDate(context);
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _date,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: 'হিসাবের তারিখ (yyyy-MM-dd)',
                      ),
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: TextField(
                  textAlign: TextAlign.start,
                  controller: remarkCon,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'মন্তব্য',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 20, right: 12),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            textStyle: TextStyle(
              color: Colors.white
            )
          ),
                child: Container(
                  width: 150,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(0.0),
                    gradient: LinearGradient(
                      colors: [
                        Color(Helper.getHexToInt(CommonColor.primaryColor)),
                        Color(Helper.getHexToInt(CommonColor.primaryColor))
                      ],
                    ),
                  ),
                  child: Text(
                    'জমা দিন',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                ),
                onPressed: () {
                  //send server cattle info
                  setCattleData();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setCattleData() {
    //cattleNameCon.text = prefs.getString('token').toString();
    if (selectedFarms == null) {
      Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
    } else if (selectedAccountType == null) {
      Common.setWrongToast('হিসাবের ধরণ নির্বাচন করুন');
    } else if (quantityCon.text.length == 0) {
      Common.setWrongToast('পরিমাণ প্রদান করুন');
    } else if (unitIncomeExpense.text.length == 0) {
      Common.setWrongToast('প্রতি ইউনিট আয়/ব্যয় প্রদান করুন');
    } else if (totalCon.text.length == 0) {
      Common.setWrongToast('সর্বমোট প্রদান করুন');
    } else if (_date.text.length == 0) {
      Common.setWrongToast('অসুস্থ হওয়ার তারিখ প্রদান করুন');
    } else if (remarkCon.text.length == 0) {
      Common.setWrongToast('মন্তব্য প্রদান করুন');
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Customdialog());

      setState(() {
        dataPush();
      });
    }
  }

  void dataPush() async {
    http.Response response = await http.post(
        Uri.parse(NetworkServices.baseUrl + 'form/store-account-entry'),
        body: {
          'farm_id': selectedFarms,
          'account_id': selectedIncomeAccountName,
          'quantity': quantityCon.text,
          'amount_per_unit': unitIncomeExpense.text,
          'total_amount': totalCon.text,
          'date': _date.text,
          'remark': remarkCon.text,
        },
        headers: headersToken);

    print(response.statusCode);
    print(response.body);
    final responseJson = json.decode(response.body);
    String data = responseJson['error'];
    switch (response.statusCode) {
      case 200:
        dataInsertSuccess(context);
        break;
      case 401:
        Common.setWrongToast('আপনি আবার লগইন করুন!');
        Navigator.of(context).pushNamedAndRemoveUntil(
            Login_page.routeName, (Route<dynamic> route) => false);
        break;

      default:
        Navigator.pop(context, true);
        Common.setWrongToast(data.toString());
        break;
    }
  }

  void dataInsertSuccess(BuildContext context) async {
    Alert(
      context: context,
      type: AlertType.success,
      closeFunction: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            CowRegistrationHome.routeName, (Route<dynamic> route) => false);
        print('ffffff');
      },
      title: '',
      desc: "আপনার তথ্য গুলো সঠিক ভাবে জমা হয়েছে।",
      buttons: [
        DialogButton(
          child: Text(
            "ওকে",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            setState(() {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  CowRegistrationHome.routeName,
                  (Route<dynamic> route) => false);
            });
          },
          gradient: LinearGradient(colors: [
            Color(Helper.getHexToInt(CommonColor.primaryColor)),
            Color(Helper.getHexToInt(CommonColor.primaryColor))
          ]),
        )
      ],
    ).show();
  }
}
