import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:prani_sheba/Common/Helper.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/CattleData.dart';
import 'package:prani_sheba/model/Farm.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/services/NetworkServices.dart';
import 'package:prani_sheba/view/auth/Login_page.dart';
import 'package:prani_sheba/view/seed_filling/SeedFillingHome.dart';
import 'package:prani_sheba/widget/CustomDialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class ManualHitSend extends StatefulWidget {
  static const routeName = 'manual_hit_send';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ManualHitSend> {
  String? selectedFarms,
      selectedCattleId,
      selectedCattleGroup;

  String? selectedForm;
  List<Farm>? farmToList1;

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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    debugPrint("========  ==> api Response  : $farmsToList");

    return MaterialApp(
      home: Scaffold(
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
          title: Text('ম্যানুয়ালি হিট প্রবেশ'),
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
                              print(selectedFarms);
                            });
                            print(selectedFarms);
                          },
                          items: farmsToList?.map((FarmsData map) {
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

                    // DropdownButton(
                    //   hint: Text("নির্বাচন করুন"),
                    //   value: selectedForm,
                    //     isDense: true,
                    //     items:farmToList1?.map((map){
                    //       return DropdownMenuItem(
                    //         value: map.id,
                    //           child: Text(map.name.toString())
                    //       );
                    //     }).toList(),
                    //     onChanged: (value){
                    //
                    //     setState(() {
                    //       selectedFarms = value.toString();
                    //       print(selectedFarms);
                    //     });
                    //
                    //     })


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
                      child: Text(
                        "গরুর নাম‌",
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("নির্বাচন করুন"),
                          value: selectedCattleId,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCattleId = newValue;
                            });
                            print(selectedCattleId);
                          },
                          items: cattleToList!.map((CattleData map) {
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
              Container(
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
                          labelText: 'হিট আসার তারিখ (yyyy-MM-dd)',
                        ),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 20, right: 12),
                alignment: Alignment.centerRight,
                child: MaterialButton(
                    textColor: Colors.white,
                    padding: EdgeInsets.all(0.0),
                    shape: StadiumBorder(),
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
                      padding: EdgeInsets.symmetric(
                          horizontal: 10.0, vertical: 12.0),
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
      ),
    );
  }

  void setCattleData() {
    //cattleNameCon.text = prefs.getString('token').toString();

    if (selectedFarms == null) {
      Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
    } else if (selectedCattleId == null) {
      Common.setWrongToast('গরুর নাম নির্বাচন করুন');
    }else if (_date.text.length == 0) {
      Common.setWrongToast('হিট আসার তারিখ  প্রদান করুন');
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
    http.Response response =
    await http.post(Uri.parse(NetworkServices.baseUrl + 'form/store-manual-hit'), body: {
      'farm_id': selectedFarms,
      'cattle_id': selectedCattleId,
      'date': _date.text,
    }, headers: headersToken);

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
            SeedFillingHome.routeName, (Route<dynamic> route) => false);
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
                  SeedFillingHome.routeName,
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
