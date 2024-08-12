import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/common/date_converter.dart';
import 'package:prani_sheba/controller/ReportVaccineController.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/CattleGroup2.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/FarmsToCattle.dart';
import 'package:prani_sheba/model/FarmsToCattle2.dart';
import 'package:prani_sheba/model/cattle_vaccines.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class ReportVaccinePage extends StatefulWidget {
  static const routeName = 'report_vaccine_page';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ReportVaccinePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final ReportVaccineController productController =
      Get.put(ReportVaccineController());
  String? selectedFarms, selectedCattleGroupId, selectedCattleId;
  List<CattleGroup2> cattleGroupList = [];
  CattleGroup2? cattleGList;

  void getCattleGroupList() async {
    cattleGroupList.clear();
    cattleGList = CattleGroup2();
    cattleGList!.id = 'সমস্ত';
    cattleGList!.name = 'সমস্ত';
    cattleGroupList.add(cattleGList!);
    for (int i = 0; i < cattle_groupsToList!.length; i++) {
      cattleGList = CattleGroup2();
      cattleGList!.id = cattle_groupsToList![i].id.toString();
      cattleGList!.name = cattle_groupsToList![i].name;
      cattleGroupList.add(cattleGList!);
    }

    print(cattleGroupList.length);
  }

  List<FarmsToCattle2> cattleList = [];
  FarmsToCattle2? cattle;

  void getCattleList() async {
    cattleList.clear();
    cattle = FarmsToCattle2();
    cattle!.id = 'সমস্ত';
    cattle!.name = 'সমস্ত';
    cattleList.add(cattle!);
    for (int i = 0; i < cattleToList!.length; i++) {
      cattle = FarmsToCattle2();
      cattle!.id = cattleToList![i].id.toString();
      cattle!.name = cattleToList![i].name;
      cattleList.add(cattle!);
    }

    print(cattleGroupList.length);
  }

  DateTime selectedBirthDayDate = DateTime.now();
  DateTime selectedLastDay = DateTime.now();
  TextEditingController _dateBirthDay = new TextEditingController();
  TextEditingController _dateLastDay = new TextEditingController();

  Future<Null> _selectBirthDayDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedBirthDayDate,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2500));
    if (picked != null && picked != selectedBirthDayDate)
      selectedBirthDayDate = picked;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String string = dateFormat.format(selectedBirthDayDate);
    _dateBirthDay.value = TextEditingValue(text: string);
  }

  Future<Null> _selectedLastDay(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedLastDay,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2500));
    if (picked != null && picked != selectedLastDay) selectedLastDay = picked;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    String string = dateFormat.format(selectedLastDay);
    _dateLastDay.value = TextEditingValue(text: string);
  }

  List<FarmsToCattle> cattleDataList = [];

  Future _cattleData(int id) async {
    cattleDataList.clear();
    FarmsToCattle commonData;

    for (int i = 0; i < cattleToList!.length; i++) {
      if (cattleToList![i].id == id) {
        commonData = FarmsToCattle();
        commonData.name = cattleToList![i].name;
        if (cattleToList![i].frontImage1 == null) {
          commonData.frontImage1 = null;
        } else {
          commonData.frontImage1 = cattleToList![i].frontImage1;
        }
        cattleDataList.add(commonData);
      }
    }
  }

  var diseaseHistoryChecked = [];
  var userStatusDisHistory = [];
  CattleVaccines? cattleDiseases;

  Future<List<CattleVaccines>> _getDiseaseHistories() async {
    List<CattleVaccines> cattle = [];
    for (int i = 0; i < cattle_vaccinesToList!.length; i++) {
      cattleDiseases = CattleVaccines();
      cattleDiseases!.id = cattle_vaccinesToList![i].id;
      cattleDiseases!.name = cattle_vaccinesToList![i].name;
      cattle.add(cattleDiseases!);
      userStatusDisHistory.add(false);
    }
    return cattle;
  }

  bool visible = true;

  loadProgress() {
    if (visible == true) {
      setState(() {
        visible = false;
      });
    } else {
      setState(() {
        visible = true;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getCattleGroupList();
    log(cattleToList!.length.toString());
    getCattleList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _key,
        appBar: AppBar(
          backgroundColor: Color(Helper.getHexToInt(CommonColor.primaryColor)),
          // you can put Icon as well, it accepts any widget.
          //title: Text ("Your Title"),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            iconSize: 20.0,
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          centerTitle: true,
          title: Text('টিকা'),
        ),
        body: Obx(() {
          return Column(
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
                        'গ্রুপ',
                        textAlign: TextAlign.start,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                    Container(
                      child: DropdownButtonHideUnderline(
                        child: DropdownButton<String>(
                          hint: Text("নির্বাচন করুন"),
                          value: selectedCattleGroupId,
                          isDense: true,
                          onChanged: (String? newValue) {
                            setState(() {
                              selectedCattleGroupId = newValue;
                            });
                            print(selectedCattleGroupId);
                          },
                          items: cattleGroupList.map((CattleGroup2 map) {
                            return DropdownMenuItem<String>(
                                value: map.id,
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
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'গরু',
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
                          items: cattleList.map((FarmsToCattle2 map) {
                            return DropdownMenuItem<String>(
                                value: map.id,
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
              /* Container(
                margin: EdgeInsets.only(top: 5, left: 15, right: 12),
                alignment: Alignment.centerLeft,
                child: Text(
                  'টিকা',
                  textAlign: TextAlign.start,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                ),
              ),
              Container(
                child: FutureBuilder(
                  future: _getDiseaseHistories(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data.length == 0) {
                      return Container(child: Center(child: Text("No Data Found")));
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: snapshot.data.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ListTile(
                            title: Text(
                              snapshot.data[index].name,
                              style: TextStyle(color: Colors.grey),
                            ),
                            trailing: Checkbox(
                                value: userStatusDisHistory[index],
                                activeColor: Colors.green,
                                onChanged: (bool val) {
                                  setState(() {
                                    userStatusDisHistory[index] = !userStatusDisHistory[index];

                                    if (val) {
                                      diseaseHistoryChecked.add(snapshot.data[index].id);
                                      print(diseaseHistoryChecked.toList());
                                    } else {
                                      diseaseHistoryChecked.remove(snapshot.data[index].id);
                                      print(diseaseHistoryChecked.toList());
                                      print('un checked');
                                    }
                                  });
                                }),
                            onTap: () {},
                          );
                        },
                      );
                    }
                  },
                ),
              ),*/
              Container(
                margin: EdgeInsets.only(top: 0, left: 15, right: 12),
                child: GestureDetector(
                    onTap: () {
                      _selectBirthDayDate(context);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _dateBirthDay,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'শুরুর তারিখ (yyyy-MM-dd)',
                        ),
                      ),
                    )),
              ),
              Container(
                margin: EdgeInsets.only(top: 0, left: 15, right: 12),
                child: GestureDetector(
                    onTap: () {
                      _selectedLastDay(context);
                    },
                    child: AbsorbPointer(
                      child: TextField(
                        controller: _dateLastDay,
                        keyboardType: TextInputType.datetime,
                        decoration: InputDecoration(
                          labelText: 'শেষ তারিখ (yyyy-MM-dd)',
                        ),
                      ),
                    )),
              ),
              customButtonSearch(onTap: () {
                setCattleData();
              }),
              productController.dataList.length != 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: ListView.builder(
                        shrinkWrap: true,
                        physics: ScrollPhysics(),
                        itemCount: productController.dataList.length,
                        itemBuilder: (context, index) {
                          _cattleData(
                              productController.dataList[index].cattleId!);
                          return Column(
                            children: [
                              Row(
                                children: [
                                  Container(
                                    width: 100,
                                    height: 85,
                                    margin: EdgeInsets.only(right: 10),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(0),
                                      child: cattleDataList[index]
                                                  .frontImage1 !=
                                              null
                                          ? Image.network(
                                              '${NetworkServices.imageUrl + cattleDataList[index].frontImage1!}',
                                              width: 100,
                                              height: 85,
                                              fit: BoxFit.fill,
                                              colorBlendMode: BlendMode.color)
                                          : Image.asset(
                                              'assets/images/no_image.png',
                                              width: 100,
                                              height: 85,
                                              fit: BoxFit.fill,
                                              colorBlendMode: BlendMode.color),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            'নাম: ${cattleDataList[index].name}',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            'দেওয়া হয়েছেঃ ${DateConverter.formatDateIOS(productController.dataList[index].date!)}',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            'মন্তব্যঃ ${productController.dataList[index].remark ?? "নাই"}',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.grey,
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Divider(color: Colors.grey),
                            ],
                          );
                        },
                      ),
                    )
                  : Container(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 30),
                          child: Text('No Data Found')))
            ],
          );
        }));
  }

  void setCattleData() {
    if (selectedFarms == null) {
      Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
    } else if (selectedCattleGroupId == null) {
      Common.setWrongToast('গ্রুপ নির্বাচন করুন');
    } else if (selectedCattleId == null) {
      Common.setWrongToast('গরু নির্বাচন করুন!');
    } else if (_dateBirthDay.text.length == 0) {
      Common.setWrongToast('শুরুর তারিখ প্রদান করুন!');
    } else if (_dateLastDay.text.length == 0) {
      Common.setWrongToast('শেষ তারিখ প্রদান করুন!');
    } else {
      Fluttertoast.showToast(msg: 'Please wait......');
      productController.fetchReportVaccine(
          selectedFarms!,
          selectedCattleGroupId!,
          selectedCattleId!,
          _dateBirthDay.text,
          _dateLastDay.text,
          diseaseHistoryChecked.toList().toString());
    }
  }
}
