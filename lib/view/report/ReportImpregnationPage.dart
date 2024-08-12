import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/custom_app_bar.dart';
import 'package:prani_sheba/common/date_converter.dart';
import 'package:prani_sheba/common/style_data.dart';
import 'package:prani_sheba/controller/ReportImpregnationController.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/CattleGroup2.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/FarmsToCattle.dart';
import 'package:prani_sheba/model/FarmsToCattle2.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class ReportImpregnationPage extends StatefulWidget {
  static const routeName = 'report_impregnation_page';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ReportImpregnationPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final ReportImpregnationController productController = Get.put(ReportImpregnationController());
  String? selectedFarms, selectedCattleGroupId, selectedCattleId, selectedCattleBreedId;
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

  List<FarmsToCattle2> cattleBreedList = [];
  FarmsToCattle2? cattleBreed;

  void getCattleBreedList() async {
    cattleBreedList.clear();
    for (int i = 0; i < cattle_breedsToList!.length; i++) {
      cattleBreed = FarmsToCattle2();
      cattleBreed!.id = cattle_breedsToList![i].id.toString();
      cattleBreed!.name = cattle_breedsToList![i].name;
      cattleBreedList.add(cattleBreed!);
    }

    print(cattleBreedList.length);
  }

  String _dateBirthDay = '';
  String _dateLastDay = '';

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

    getCattleBreedList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: CustomAppBar(title: 'বীজ ভরন'),
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
                      'বীজের ধরণ',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedCattleBreedId,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCattleBreedId = newValue;
                          });
                          print(selectedCattleBreedId);
                        },
                        items: cattleBreedList.map((FarmsToCattle2 map) {
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
            size15,
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      _dateBirthDay = await selectDate(context, date: _dateBirthDay);
                      setState(() {});
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
                            Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 18),
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
                      _dateLastDay = await selectDate(context, date: _dateLastDay);
                      setState(() {});
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
                            Icon(Icons.calendar_today_outlined, color: Colors.grey, size: 20),
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
            Obx(() {
              if (productController.isLoading.value)
                return Center(child: CircularProgressIndicator());
              else
                return productController.dataList.length != 0
                    ? Expanded(
                        child: SingleChildScrollView(
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
                                Container(margin: EdgeInsets.only(top: 0, bottom: 5, left: 5, right: 5), child: Divider()),
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
                                                    ? Image.network('${NetworkServices.imageUrl + cattleDataList[index].frontImage1!}',
                                                        width: 100, height: 85, fit: BoxFit.fill, colorBlendMode: BlendMode.color)
                                                    : Image.asset('assets/images/cow_icon.png',
                                                        width: 100, height: 85, fit: BoxFit.fill, colorBlendMode: BlendMode.color),
                                              ),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      'নাম: ${cattleDataList[index].name}',
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      'দেওয়া হয়েছেঃ ${DateConverter.formatDateIOS(productController.dataList[index].palDate!)}',
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      'টাইপঃ ${productController.dataList[index].palType ?? "নাই"}',
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
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
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    : Container(child: Padding(padding: const EdgeInsets.only(top: 30), child: Text('No Data Found')));
            }),
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
    } else if (selectedCattleBreedId == null) {
      Common.setWrongToast('বীজের ধরণ নির্বাচন করুন!');
    } else if (_dateBirthDay.length == 0) {
      Common.setWrongToast('শুরুর তারিখ প্রদান করুন!');
    } else if (_dateLastDay.length == 0) {
      Common.setWrongToast('শেষ তারিখ প্রদান করুন!');
    } else {
      productController.fetchReportImpregnation(
          selectedFarms!, selectedCattleGroupId!, selectedCattleId!, _dateBirthDay, _dateLastDay, selectedCattleBreedId!);
    }
  }
}
