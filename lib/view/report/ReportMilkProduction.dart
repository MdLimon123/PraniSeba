import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/common/style_data.dart';
import 'package:prani_sheba/controller/ReportMilkProductinController.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/CattleGroup2.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/FarmsToCattle.dart';
import 'package:prani_sheba/model/FarmsToCattle2.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class ReportMilkProduction extends StatefulWidget {
  static const routeName = 'report_milk_production';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ReportMilkProduction> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final ReportMilkProductinController productController = Get.put(ReportMilkProductinController());
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
  String _dateBirthDay = '';
  String _dateLastDay = '';

  Future<Null> _selectBirthDayDate(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedBirthDayDate, firstDate: DateTime(1901, 1), lastDate: DateTime(2500));
    if (picked != null && picked != selectedBirthDayDate) selectedBirthDayDate = picked;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");
    setState(() {
      _dateBirthDay = dateFormat.format(selectedLastDay);
    });
  }

  Future<Null> _selectedLastDay(BuildContext context) async {
    final DateTime? picked =
        await showDatePicker(context: context, initialDate: selectedLastDay, firstDate: DateTime(1901, 1), lastDate: DateTime(2500));
    if (picked != null && picked != selectedLastDay) selectedLastDay = picked;

    DateFormat dateFormat = DateFormat("yyyy-MM-dd");

    setState(() {
      _dateLastDay = dateFormat.format(selectedLastDay);
    });
  }

  List<FarmsToCattle> cattleDataList = [];

  Future _cattleData(int id) async {
    cattleDataList.clear();
    FarmsToCattle commonData;

    for (int i = 0; i < cattleToList!.length; i++) {
      if (cattleToList![i].id == id) {
        commonData = FarmsToCattle();
        commonData.name = cattleToList![i].name;
        commonData.frontImage1 = cattleToList![i].frontImage1;
        cattleDataList.add(commonData);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCattleGroupList();

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
            }),
        centerTitle: true,
        title: Text('দুধ উৎপাদন'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 10),
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
                              value: map.id.toString(),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 80.0, // for example
                                  child: Text(map.name!, textAlign: TextAlign.right),
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Container(margin: EdgeInsets.only(top: 0, left: 15, right: 12), child: Divider()),
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
                                  child: Text(map.name!, textAlign: TextAlign.right),
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(margin: EdgeInsets.only(top: 0, left: 15, right: 12), child: Divider()),
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
                                  child: Text(map.name!, textAlign: TextAlign.right),
                                ),
                              ));
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(margin: EdgeInsets.only(top: 0, left: 15, right: 12), child: Divider()),

            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _selectBirthDayDate(context);
                    },
                    child: Column(
                      children: [
                        Text('শুরুর তারিখ (yyyy-MM-dd)', style: TextStyle(fontSize: 12.5, color: Colors.grey)),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(_dateBirthDay),
                            )),
                            Icon(Icons.calendar_today_outlined, color: Colors.grey),
                          ],
                        ),
                        SizedBox(height: 2),
                        Container(
                          height: 1,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ),
                width10,
                Expanded(
                  child: InkWell(
                    onTap: () {
                      _selectedLastDay(context);
                    },
                    child: Column(
                      crossAxisAlignment: crossAxisStart,
                      children: [
                        Text(
                          'শেষ তারিখ (yyyy-MM-dd)',
                          style: TextStyle(fontSize: 12.5, color: Colors.grey),
                        ),
                        Row(
                          children: [
                            Expanded(child: Text(_dateLastDay)),
                            Icon(Icons.calendar_today_outlined, color: Colors.grey),
                          ],
                        ),
                        SizedBox(height: 2),
                        Container(
                          height: 1,
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
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  print("Total Products = " + productController.dataList.length.toString());

                return SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                    child: Column(
                      children: [
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0),
                                child: Text(
                                  'Total Cow ',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0),
                                child: Text(
                                  '${productController.productList.value.cattleCount.toString()}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(margin: EdgeInsets.only(top: 0, left: 0, right: 0), child: Divider()),
                        Container(
                          margin: EdgeInsets.only(top: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0),
                                child: Text(
                                  'Total Milk ',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0),
                                child: Text(
                                  '${productController.productList.value.mlikCount.toString()}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(margin: EdgeInsets.only(top: 0, left: 0, right: 0), child: Divider()),
                        productController.dataList.length != 0
                            ? Container(
                                margin: EdgeInsets.only(top: 5, bottom: 5),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(top: 0),
                                      child: Text(
                                        'Picture',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(top: 0),
                                      child: Text(
                                        'Cow',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 20, color: Colors.black),
                                      ),
                                    ),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      margin: EdgeInsets.only(top: 0),
                                      child: Text(
                                        'Quantity',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(fontSize: 20, color: Colors.black),
                                      ),
                                    )
                                  ],
                                ),
                              )
                            : SizedBox.shrink(),


                        ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: productController.dataList.length,
                          itemBuilder: (context, index) {
                            _cattleData(productController.dataList[index].cattleId!);
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
                                        child: cattleDataList[index].frontImage1 != null
                                            ? Image.network(
                                                '${NetworkServices.imageUrl + cattleDataList[index].frontImage1!}',
                                                width: 100,
                                                height: 85,
                                                fit: BoxFit.fill,
                                                colorBlendMode: BlendMode.color,
                                              )
                                            : Image.asset(
                                                'assets/images/cow_icon.png',
                                                width: 100,
                                                height: 85,
                                                fit: BoxFit.fill,
                                                colorBlendMode: BlendMode.color,
                                              ),
                                      ),
                                    ),
                                    Flexible(
                                        child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            'গরুর নাম: ${cattleDataList[index].name}',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            '${productController.dataList[index].value}',
                                            textAlign: TextAlign.left,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                      ],
                                    ))
                                  ],
                                ),
                                Divider(color: Colors.grey),
                              ],
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  void setCattleData() {
    if (selectedFarms == null) {
      Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
    } else if (selectedCattleGroupId == null) {
      Common.setWrongToast('গ্রুপ নির্বাচন করুন');
    } else if (selectedCattleId == null) {
      Common.setWrongToast('গরু নির্বাচন করুন!');
    } else if (_dateBirthDay.length == 0) {
      Common.setWrongToast('শুরুর তারিখ প্রদান করুন!');
    } else if (_dateLastDay.length == 0) {
      Common.setWrongToast('শেষ তারিখ প্রদান করুন!');
    } else {
      productController.fetchMilkProduction(selectedFarms!, selectedCattleGroupId!, selectedCattleId!, _dateBirthDay, _dateLastDay);
    }
  }
}
