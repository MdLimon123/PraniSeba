import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/controller/ReportFoodConsumWeightController.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/CattleGroup2.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/FarmsToCattle.dart';
import 'package:prani_sheba/model/FarmsToCattle2.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class ReportFoodConsumWeightPage extends StatefulWidget {
  static const routeName = 'report_food-consumption-weight_page';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ReportFoodConsumWeightPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final ReportFoodConsumWeightController reportController = Get.put(ReportFoodConsumWeightController());
  String? selectedFarms, selectedCattleGroupId, selectedCattleId, selectedDays;

  CattleGroup2? cattleGList;
  List<CattleGroup2> cattleGroupList = [];

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
        commonData.weight = cattleToList![i].weight;
        cattleDataList.add(commonData);
      }
    }
  }

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
    '30'
  ];

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
        title: Text('খাবার গ্রহণ ও ওজন'),
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
            Container(
              margin: EdgeInsets.only(top: 2, left: 15, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'দিন',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedDays,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDays = newValue;
                          });
                          print(selectedDays);
                        },
                        items: _avrMilkManufacture.map((location) {
                          return DropdownMenuItem(
                              value: location,
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 80.0, // for example
                                  child: Text(location, textAlign: TextAlign.right),
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
            customButtonSearch(onTap: () {
              setCattleData();
            }),
            //List view show
            Expanded(
              child: Obx(() {
                if (reportController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  print("Total Products = " + reportController.dataList.length.toString());

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
                                  '${reportController.productList.value.cattleCount.toString()}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 20, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(margin: EdgeInsets.only(top: 0, bottom: 5, left: 5, right: 5), child: Divider()),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: ScrollPhysics(),
                          itemCount: reportController.dataList.length,
                          itemBuilder: (context, index) {
                            _cattleData(reportController.dataList[index].cattleId!);
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
                                        child: Column(
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
                                            style: TextStyle(fontSize: 15, color: Colors.black, fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 5),
                                          child: Text(
                                            'তারিখ: ${reportController.dataList[index].date}',
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
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(top: 0),
                                        child: Text(
                                          'খাবার গ্রহণ',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 17, color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(top: 0),
                                        child: Text(
                                          'ওজন পরিমাপ',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 17, color: Colors.black),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(top: 0),
                                        child: Text(
                                          'ওজন',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 17, color: Colors.black),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 5, bottom: 5),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(left: 5),
                                        child: reportController.dataList[index].hasConsumedFood!
                                            ? Text(
                                                'হ্যা',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 15, color: Colors.grey),
                                              )
                                            : Text(
                                                'না',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 15, color: Colors.grey),
                                              ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(top: 0),
                                        child: reportController.dataList[index].hasMeasuredWeight!
                                            ? Text(
                                                'হ্যা',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 15, color: Colors.grey),
                                              )
                                            : Text(
                                                'না',
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(fontSize: 15, color: Colors.grey),
                                              ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        margin: EdgeInsets.only(right: 5),
                                        child: Text(
                                          '${cattleDataList[index].weight}',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(fontSize: 15, color: Colors.grey),
                                        ),
                                      )
                                    ],
                                  ),
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
    } else if (selectedDays == null) {
      Common.setWrongToast('সময় নির্বাচন করুন!');
    } else {
      reportController.fetchReport(selectedFarms!, selectedCattleGroupId!, selectedCattleId!, selectedDays!);
    }
  }
}
