import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/DiseaseHistories.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/cattle_breeds.dart';
import 'package:prani_sheba/model/cattle_groups.dart';
import 'package:prani_sheba/model/healthInfoChckbox.dart';
import 'package:prani_sheba/model/insurance_companies.dart';
import 'package:prani_sheba/model/insurance_types.dart';
import 'package:prani_sheba/view/cow_registraton/CowImageUpload.dart';

class CowRegistrationsInfo extends StatefulWidget {
  static const routeName = 'cow_registrations_info';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CowRegistrationsInfo> {
  TextEditingController tagIdCon = TextEditingController();
  TextEditingController cattleNameCon = TextEditingController();
  TextEditingController weightCon = TextEditingController();
  TextEditingController insuranceNumberCon = TextEditingController();

  List<String> _cattleGender = ['গাভী', 'দামড়া'];
  List<String> _yesNoList = ['হ্যা', 'না'];
  List<String> _serial1to8 = ['1', '2', '3', '4', '5', '6', '7', '8'];
  List<String> _geneticPercentage = [
    '50',
    '55',
    '60',
    '65',
    '70',
    '80',
    '85',
    '75',
    '87.5',
    '100',
  ];
  List<String> _avrMilkManufacture = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '10',
    '11',
    '12',
    '13',
    '14',
    '15',
    '16',
    '17',
    '19',
    '20',
    '21',
    '22',
    '23',
    '24',
    '25',
    '26',
    '27',
    '28',
    '29',
    '30',
    '31',
    '32',
    '33',
    '34',
    '35',
    '36'
  ];
  String? selectedFarms,
      selectedCattleGroup,
      selectedCattleBreed,
      selectedInsuranceCompany,
      selectedInsuranceType,
      selectedCattleGender,
      selectedHealthInfo,
      selectedAvrMilkManufacture,
      selectedDhuddhonYsno,
      selectedCattleCount,
      selectedGeneticPercentage;

  bool valuefirst = false;
  bool valuesecond = false;
  bool selected = false;
  var userStatus = [];
  var health_infoChecked = [];
  var disease_historyChecked = [];

  Future<List<HealthInfoCheckbox>> _getHealthifoData() async {
    List<HealthInfoCheckbox> cattle = [];
    for (var u in healthInfoToList!) {
      HealthInfoCheckbox heath = HealthInfoCheckbox(u.id, u.name);

      cattle.add(heath);
      userStatus.add(false);
    }
    return cattle;
  }

  bool selectedDisHistory = false;
  var userStatusDisHistory = [];

  Future<List<DiseaseHistories>> _getDiseaseHistories() async {
    List<DiseaseHistories> cattle = [];
    for (var u in diseaseHistoriesToList!) {
      DiseaseHistories heath = DiseaseHistories(u.id, u.name);

      cattle.add(heath);
      userStatusDisHistory.add(false);
    }
    return cattle;
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
      setState(() {
        selectedBirthDayDate = picked;

        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        String string = dateFormat.format(selectedBirthDayDate);
        _dateBirthDay.value = TextEditingValue(text: string);
      });
  }

  Future<Null> _selectedLastDay(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedLastDay,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2500));
    if (picked != null && picked != selectedLastDay)
      setState(() {
        selectedLastDay = picked;

        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        String string = dateFormat.format(selectedLastDay);
        _dateLastDay.value = TextEditingValue(text: string);
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
        title: Text('গাভী/ষাঁড় সম্পর্কিত তথ্য'),
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
              margin: EdgeInsets.only(top: 15, left: 12, right: 12),
              child: Container(
                width: double.infinity,
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
                  'সাধারণ তথ্য',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
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
                                  child: Text(map.name.toString(),
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
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: TextField(
                  textAlign: TextAlign.start,
                  controller: tagIdCon,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'গরু আইডি/কানে লাগানোর ট্যাগ',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 12, right: 12),
              child: Container(
                width: double.infinity,
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
                  'গাভী/ষাঁড় সম্পর্কিত তথ্য',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: TextField(
                  textAlign: TextAlign.start,
                  controller: cattleNameCon,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'গরুর নাম',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 15, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "গ্রুপ‌",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedCattleGroup,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCattleGroup = newValue;
                          });
                          print(selectedCattleGroup);
                        },
                        items: cattle_groupsToList!.map((CattleGroups map) {
                          return DropdownMenuItem<String>(
                              value: map.id.toString(),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 80.0, // for example
                                  child: Text(map.name.toString(),
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
                      'গরুর জাত',
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
                                  child: Text(map.name.toString(),
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
                        labelText: 'জন্ম তারিখ (yyyy-MM-dd)',
                      ),
                    ),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: TextField(
                  textAlign: TextAlign.start,
                  controller: weightCon,
                  autofocus: false,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'ওজন (Kg)',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
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
                      'লিঙ্গ',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedCattleGender,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCattleGender = newValue;
                          });
                          print(selectedCattleGender);
                        },
                        items: _cattleGender.map((location) {
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
              margin: EdgeInsets.only(top: 2, left: 15, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'প্রজনন স্বাস্থ্য সমস্যা',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedHealthInfo,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedHealthInfo = newValue;
                          });
                          print(selectedHealthInfo);
                        },
                        items: _yesNoList.map((location) {
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
              margin: EdgeInsets.only(top: 15, left: 12, right: 12),
              child: Container(
                width: double.infinity,
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
                  'দুধ, প্রজনন, রোগ তথ্য',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 15, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'গরু দুধ উৎপাদন (লিটার)',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedAvrMilkManufacture,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedAvrMilkManufacture = newValue;
                          });
                          print(selectedAvrMilkManufacture);
                        },
                        items: _avrMilkManufacture.map((location) {
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
              margin: EdgeInsets.only(top: 2, left: 15, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'এখনো দুধ দহন করা হয়?',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedDhuddhonYsno,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDhuddhonYsno = newValue;
                          });
                          print(selectedDhuddhonYsno);
                        },
                        items: _yesNoList.map((location) {
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
              margin: EdgeInsets.only(top: 2, left: 15, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'ইতিপূর্বে কয়বার বাচ্চা দিয়েছে',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedCattleCount,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCattleCount = newValue;
                          });
                          print(selectedCattleCount);
                        },
                        items: _serial1to8.map((location) {
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
              child: GestureDetector(
                  onTap: () {
                    _selectedLastDay(context);
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _dateLastDay,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: 'সর্বশেষ বাছুর হওয়ার তারিখ (yyyy-MM-dd)',
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
                      'জেনিটিক শতাংশ',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedGeneticPercentage,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedGeneticPercentage = newValue;
                          });
                          print(selectedGeneticPercentage);
                        },
                        items: _geneticPercentage.map((location) {
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
            // === history===///diseaseHistories
            Container(
              margin: EdgeInsets.only(top: 15, left: 12, right: 12),
              child: Container(
                width: double.infinity,
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
                  'বংশগত রোগের ইতিহাস',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              ),
            ),
            Container(
              child: FutureBuilder(
                future: _getDiseaseHistories(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(
                        child: Center(child: Text("Loading...")));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].name),
                          trailing: Checkbox(
                              value: userStatusDisHistory[index],
                              onChanged: (bool? val) {
                                setState(() {
                                  userStatusDisHistory[index] =
                                  !userStatusDisHistory[index];

                                  if (val!) {
                                    print('checked');
                                    disease_historyChecked
                                        .add(snapshot.data[index].id);
                                    print(disease_historyChecked.toList());
                                  } else {
                                    disease_historyChecked
                                        .remove(snapshot.data[index].id);
                                    print(disease_historyChecked.toList());
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
            ),

            Container(
              margin: EdgeInsets.only(top: 15, left: 12, right: 12),
              child: Container(
                width: double.infinity,
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
                  'প্রজনন সাস্থ্য সম্পর্কিত তথ্য',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              ),
            ),
            Container(
              child: FutureBuilder(
                future: _getHealthifoData(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(
                        child: Center(child: Text("Loading...")));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: ScrollPhysics(),
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(snapshot.data[index].name),
                          trailing: Checkbox(
                              value: userStatus[index],
                              onChanged: (bool? val) {
                                setState(() {
                                  userStatus[index] = !userStatus[index];

                                  if (val!) {
                                    print('checked');
                                    health_infoChecked
                                        .add(snapshot.data[index].id);
                                    print(health_infoChecked.toList());
                                  } else {
                                    health_infoChecked
                                        .remove(snapshot.data[index].id);
                                    print(health_infoChecked.toList());
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
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 12, right: 12),
              child: Container(
                width: double.infinity,
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
                  'ইনসিওরেন্স তথ্য',
                  textAlign: TextAlign.start,
                  style: TextStyle(fontSize: 15.0, color: Colors.white),
                ),
                padding:
                EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 15, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'ইনসিওরেন্স কোম্পানি',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedInsuranceCompany,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedInsuranceCompany = newValue;
                          });
                          print(selectedInsuranceCompany);
                        },
                        items: insurance_companiesToList
                            !.map((InsuranceCompanies map) {
                          return DropdownMenuItem<String>(
                              value: map.id.toString(),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 80.0, // for example
                                  child: Text(map.name.toString(),
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
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: TextField(
                  textAlign: TextAlign.start,
                  controller: insuranceNumberCon,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'ইনসিওরেন্স নং',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 2, left: 15, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      'ইনসিওরেন্স ধরণ',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedInsuranceType,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedInsuranceType = newValue;
                          });
                          print(selectedInsuranceType);
                        },
                        items:
                        insurance_typesToList!.map((InsuranceTypes map) {
                          return DropdownMenuItem<String>(
                              value: map.id.toString(),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 80.0, // for example
                                  child: Text(map.name.toString(),
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
                    'পরবর্তী ধাপ',
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
    } else if (tagIdCon.text.length == 0) {
      Common.setWrongToast('গরু আইডি/কানে লাগানোর ট্যাগ প্রদান করুন');
    } else if (cattleNameCon.text.length == 0) {
      Common.setWrongToast('গরুর নাম প্রদান করুন');
    } else if (selectedCattleGroup == null) {
      Common.setWrongToast('গ্রুপ নির্বাচন করুন!');
    } else if (selectedCattleBreed == null) {
      Common.setWrongToast('গরুর জাত নির্বাচন করুন!');
    } else if (_dateBirthDay.text.length == 0) {
      Common.setWrongToast('জন্ম তারিখ প্রদান করুন');
    } else if (weightCon.text.length == 0) {
      Common.setWrongToast('ওজন প্রদান করুন');
    } else if (selectedCattleGender == null) {
      Common.setWrongToast('লিঙ্গ নির্বাচন করুন!');
    } else if (selectedHealthInfo == null) {
      Common.setWrongToast('প্রজনন স্বাস্থ্য সমস্যা নির্বাচন করুন!');
    } else if (selectedAvrMilkManufacture == null) {
      Common.setWrongToast('গরু দুধ উৎপাদন (লিটার) নির্বাচন করুন!');
    } else if (selectedDhuddhonYsno == null) {
      Common.setWrongToast('দুধ দহন করা হয় কি না নির্বাচন করুন!');
    } else if (selectedCattleCount == null) {
      Common.setWrongToast('ইতিপূর্বে কয়বার বাচ্চা দিয়েছে নির্বাচন করুন!');
    } else if (_dateLastDay.text.length == 0) {
      Common.setWrongToast('সর্বশেষ বাছুর হওয়ার তারিখ প্রদান করুন');
    } else if (selectedGeneticPercentage == null) {
      Common.setWrongToast('জেনিটিক শতাংশ নির্বাচন করুন!');
    } else if (selectedInsuranceCompany == null) {
      Common.setWrongToast('ইনসিওরেন্স কোম্পানি নির্বাচন করুন!');
    } else if (insuranceNumberCon.text.length == 0) {
      Common.setWrongToast('ইনসিওরেন্স নং প্রদান করুন');
    } else if (selectedInsuranceType == null) {
      Common.setWrongToast('ইনসিওরেন্স ধরণ নির্বাচন করুন!');
    } else {
      setState(() {
        Common.selectedFarms = selectedFarms;
        Common.tagIdCon = tagIdCon.text;
        Common.cattleNameCon = cattleNameCon.text;
        Common.selectedCattleGroup = selectedCattleGroup;
        Common.selectedCattleBreed = selectedCattleBreed;
        Common.dateBirthDay = _dateBirthDay.text;
        Common.weightCon = weightCon.text;
        Common.selectedCattleGender = selectedCattleGender;
        Common.selectedHealthInfo = selectedHealthInfo;
        Common.selectedAvrMilkManufacture = selectedAvrMilkManufacture;
        Common.selectedDhuddhonYsno = selectedDhuddhonYsno;
        Common.selectedCattleCount = selectedCattleCount;
        Common.dateLastDay = _dateLastDay.text;
        Common.selectedGeneticPercentage = selectedGeneticPercentage;
        Common.selectedInsuranceCompany = selectedInsuranceCompany;
        Common.insuranceNumberCon = insuranceNumberCon.text;
        Common.selectedInsuranceType = selectedInsuranceType;
        Common.diseaseHistoryChecked =
            disease_historyChecked.toList().toString();
        Common.healthInfoChecked = health_infoChecked.toList().toString();
        Navigator.pushNamed(context, CowImageUpload.routeName);
      });
    }
  }

  /* void dataPush() async {
    http.Response response =
        await http.post(NetworkServices.baseUrl + 'form/store-cattle', body: {
      'farm_id': selectedFarms,
      'tag': tagIdCon.text,
      'name': cattleNameCon.text,
      'cattle_group_id': selectedCattleGroup,
      'cattle_breed_id': selectedCattleBreed,
      'birth_date': _dateBirthDay.text,
      'weight': weightCon.text,
      'gender': selectedCattleGender,
      'health_problem': selectedHealthInfo,
      'avg_milk_production': selectedAvrMilkManufacture,
      'milk_production_status': selectedDhuddhonYsno,
      'calf_count': selectedCattleCount,
      'last_calf_birth_date': _dateLastDay.text,
      'genetic_percentage': selectedGeneticPercentage,
      'insurance_company_id': selectedInsuranceCompany,
      'insurance_no': insuranceNumberCon.text,
      'insurance_type_id': selectedInsuranceType,
      'disease_history_ids': disease_historyChecked.toList().toString(),
      'health_info_ids': health_infoChecked.toList().toString(),
    }, headers: {
      'Token': prefs.getString('token').toString()
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
  }*/
}
