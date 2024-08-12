import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/CattleData.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/ManualHitData.dart';
import 'package:prani_sheba/model/cattle_breeds.dart';
import 'package:prani_sheba/model/seed_companies.dart';
import 'package:prani_sheba/services/NetworkServices.dart';
import 'package:prani_sheba/view/auth/Login_page.dart';
import 'package:prani_sheba/view/seed_filling/SeedFillingHome.dart';
import 'package:prani_sheba/widget/CustomDialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class SeedFillingInfo extends StatefulWidget {
  static const routeName = 'seed_filling-info';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<SeedFillingInfo> {
  TextEditingController straw_numberCon = TextEditingController();
  TextEditingController worker_infoCon = TextEditingController();
  bool natural = false;
  bool artificial = false;

  String? selectedFarms,
      selectedWaysToPall,
      selectedCattleBreed,
      selectedCattleBreed2,
      selectedSeedCompany,
      selectedSeedPercentage,
      selectedCattleId,
      selectedManualHitId;
  List<String> _waysToPall = ['প্রাকৃতিক', 'কৃত্রিম প্রজনন'];
  List<String> _seedPercentage = [
    '50%',
    '75%',
    '87.5%',
    '100%',
  ];
  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
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
          title: Text('বীজ ভরন সংক্রান্ত তথ্য'),
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
                      child: Text(
                        "গাভীর নাম‌",
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
                margin: EdgeInsets.only(top: 2, left: 15, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      child: Text(
                       'হিট আসার তারিখ',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("নির্বাচন করুন"),
                          value: selectedManualHitId,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedManualHitId = newValue;
                            });
                            print(selectedManualHitId);
                          },
                          items: manualHitsToList!.map((ManualHitData map) {
                            return DropdownMenuItem<String>(
                                value: map.id.toString(),
                                child: Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: SizedBox(
                                    width: 80.0, // for example
                                    child: Text(map.date.toString(),
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
                child: GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _date,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'পাল দেওয়ার তারিখ (yyyy-MM-dd)',
                        ),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 2, left: 15, right: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'কিভাবে পাল দেওয়া হয়েছে',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("নির্বাচন করুন"),
                          value: selectedWaysToPall,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedWaysToPall = newValue;
                              if(selectedWaysToPall == 'প্রাকৃতিক'){
                                natural = true;
                                artificial = false;
                              }
                              if(selectedWaysToPall == 'কৃত্রিম প্রজনন'){
                                natural = false;
                                artificial = true;
                              }
                            });
                            print(selectedWaysToPall);
                          },
                          items: _waysToPall.map((location) {
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
              ///===Visible and invisible======//////////
              Visibility(
                visible: artificial,
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 2, left: 15, right: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                'বীজ সংগৃহিত কোম্পানির নাম',
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            Container(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text("নির্বাচন করুন"),
                                  value: selectedSeedCompany,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedSeedCompany = newValue;
                                    });
                                    print(selectedSeedCompany);
                                  },
                                  items: seed_companiesToList!.map((SeedCompanies map) {
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
                              child: Text(
                                'বীজের ধরণ',
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            Container(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text("নির্বাচন করুন"),
                                  value: selectedCattleBreed2,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedCattleBreed2 = newValue;
                                    });
                                    print(selectedCattleBreed2);
                                  },
                                  items: cattle_breedsToList!.map((CattleBreeds map) {
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
                                'বীজ %',
                                textAlign: TextAlign.start,
                                style: TextStyle(color: Colors.grey, fontSize: 16),
                              ),
                            ),
                            Container(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  hint: Text("নির্বাচন করুন"),
                                  value: selectedSeedPercentage,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedSeedPercentage = newValue;
                                    });
                                    print(selectedSeedPercentage);
                                  },
                                  items: _seedPercentage.map((location) {
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
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 15, right: 12),
                        child: TextField(
                            textAlign: TextAlign.start,
                            controller: straw_numberCon,
                            autofocus: false,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'স্ট্র নাম্বার',
                              labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                            )),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 0, left: 15, right: 12),
                        child: TextField(
                            textAlign: TextAlign.start,
                            controller: worker_infoCon,
                            autofocus: false,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              labelText: 'কৃত্রিম প্রজননকর্মীর নাম ও ফোন নাম্বার',
                              labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                            )),
                      ),
                    ],
                  )
              ),
              Visibility(
                visible: natural,
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 2, left: 15, right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            child: Text(
                              'পাল দেওয়া দামড়ার ধরণ',
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ),
                          Container(
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                hint: Text("নির্বাচন করুন"),
                                value: selectedCattleBreed,
                                isDense: true,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedCattleBreed = newValue;
                                  });
                                  print(selectedCattleBreed);
                                },
                                items: cattle_breedsToList!.map((CattleBreeds map) {
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
                  ],
                ),
              ),
              //==========button/////
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

    if(natural){
      if (selectedFarms == null) {
        Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
      } else if (selectedCattleId == null) {
        Common.setWrongToast('গাভীর নাম নির্বাচন করুন');
      }else if (selectedManualHitId == null) {
        Common.setWrongToast('হিট আসার তারিখ নির্বাচন করুন');
      }else if (_date.text.length == 0) {
        Common.setWrongToast('পাল দেওয়ার তারিখ প্রদান করুন');
      } else if (selectedWaysToPall == null) {
        Common.setWrongToast('কিভাবে পাল দেওয়া হয়েছে নির্বাচন করুন');
      } else if (selectedCattleBreed == null) {
        Common.setWrongToast('পাল দেওয়া দামড়া নির্বাচন করুন');
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Customdialog());

        setState(() {
          dataPush();
        });
      }
    }else{
      if (selectedFarms == null) {
        Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
      } else if (selectedCattleId == null) {
        Common.setWrongToast('গাভীর নাম নির্বাচন করুন');
      }else if (selectedManualHitId == null) {
        Common.setWrongToast('হিট আসার তারিখ নির্বাচন করুন');
      }else if (_date.text.length == 0) {
        Common.setWrongToast('পাল দেওয়ার তারিখ প্রদান করুন');
      } else if (selectedWaysToPall == null) {
        Common.setWrongToast('কিভাবে পাল দেওয়া হয়েছে নির্বাচন করুন');
      }else if (selectedSeedCompany == null) {
        Common.setWrongToast('বীজ সংগৃহিত কোম্পানির নাম নির্বাচন করুন');
      }else if (selectedCattleBreed2 == null) {
        Common.setWrongToast('বীজের ধরণ নির্বাচন করুন');
      }else if (selectedSeedPercentage == null) {
        Common.setWrongToast('বীজ % নির্বাচন করুন');
      } else if (straw_numberCon.text.length == 0) {
        Common.setWrongToast('স্ট্র নাম্বার প্রদান করুন');
      } else if (worker_infoCon.text.length == 0) {
        Common.setWrongToast('কৃত্রিম প্রজননকর্মীর নাম ও ফোন নাম্বার প্রদান করুন');
      } else {
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => Customdialog());

        setState(() {
          dataPushArtificial();
        });
      }
    }


  }

  void dataPush() async {
    http.Response response =
    await http.post(Uri.parse(NetworkServices.baseUrl + 'form/store-impregnation'), body: {
      'farm_id': selectedFarms,
      'cattle_id': selectedCattleId,
      'pal_type': selectedWaysToPall,
      'pal_breed_id': selectedCattleBreed,
      'manual_hit_id': selectedManualHitId,
      'pal_date': _date.text,
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

  void dataPushArtificial() async {
    http.Response response =
    await http.post(Uri.parse(NetworkServices.baseUrl + 'form/store-impregnation'), body: {
      'farm_id': selectedFarms,
      'cattle_id': selectedCattleId,
      'pal_type': selectedWaysToPall,
      'pal_date': _date.text,
      'manual_hit_id': selectedManualHitId,
      'pal_breed_id': selectedCattleBreed2,
      'seed_company_id': selectedSeedCompany,
      'seed_percentage': selectedSeedPercentage,
      'straw_number': straw_numberCon.text,
      'worker_info': worker_infoCon.text,
    }, headers: {
      'Token': prefs!.getString('token').toString()
    });

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
