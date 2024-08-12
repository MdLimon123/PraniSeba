import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/controller/BDLocationsController.dart';
import 'package:prani_sheba/controller/ReportFarmsController.dart';
import 'package:prani_sheba/model/BdLocation.dart';
import 'package:prani_sheba/model/DistrictData.dart';
import 'package:prani_sheba/model/FarmsData.dart';

import '../../main.dart';

class ReportFarmsPage extends StatefulWidget {
  static const routeName = 'report_farms_page';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ReportFarmsPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final ReportFarmsController productController = Get.put(ReportFarmsController());
  final BDLocationsController bdLocationsController = Get.put(BDLocationsController());
  String? selectedFarms, selectedDivisionId, selectedZilaId, selectedUpaZilaId;

  List<DistrictData> districtDataList = [];
  DistrictData? districtData;

  void getDistrictList(String dvId) async {
    districtDataList.clear();
    int divisionId = int.parse(dvId);
    assert(divisionId is int);

    for (int i = 0; i < bdLocationsController.districtList.length; i++) {
      if (bdLocationsController.districtList[i].divisionId == divisionId) {
        districtData = DistrictData();
        districtData!.id = bdLocationsController.districtList[i].id;
        districtData!.bn_name = bdLocationsController.districtList[i].bnName;
        districtDataList.add(districtData!);
      }
    }

    print(districtDataList.length);
  }

  List<DistrictData> upazilaDataList = [];
  DistrictData? upazilaData;

  void getUpazilaList(String dvId) async {
    upazilaDataList.clear();
    int districtId = int.parse(dvId);
    assert(districtId is int);

    for (int i = 0; i < bdLocationsController.upaZilaList.length; i++) {
      if (bdLocationsController.upaZilaList[i].districtId == districtId) {
        upazilaData = DistrictData();
        upazilaData!.id = bdLocationsController.upaZilaList[i].id;
        upazilaData!.bn_name = bdLocationsController.upaZilaList[i].bnName;
        upazilaDataList.add(upazilaData!);
      }
    }

    print(upazilaDataList.length);
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
        title: Text('খামার'),
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
            Container(
              margin: EdgeInsets.only(top: 2, left: 15, right: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Text(
                      "বিভাগ‌",
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedDivisionId,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDivisionId = newValue;
                          });
                          getDistrictList(selectedDivisionId!);
                          print(selectedDivisionId);
                        },
                        items: bdLocationsController.divisionList.map((Division map) {
                          return DropdownMenuItem<String>(
                              value: map.id.toString(),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 80.0, // for example
                                  child: Text(map.bnName!, textAlign: TextAlign.right),
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
                      'জেলা',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedZilaId,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedZilaId = newValue;
                          });
                          getUpazilaList(selectedZilaId!);
                          print(selectedZilaId);
                        },
                        items: districtDataList.map((DistrictData map) {
                          return DropdownMenuItem<String>(
                              value: map.id.toString(),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 80.0, // for example
                                  child: Text(map.bn_name!, textAlign: TextAlign.right),
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
                      'থানা',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedUpaZilaId,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedUpaZilaId = newValue;
                          });
                          print(selectedUpaZilaId);
                        },
                        items: upazilaDataList.map((DistrictData map) {
                          return DropdownMenuItem<String>(
                              value: map.id.toString(),
                              child: Container(
                                margin: EdgeInsets.only(left: 10),
                                child: SizedBox(
                                  width: 80.0, // for example
                                  child: Text(map.bn_name!, textAlign: TextAlign.right),
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
                if (productController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  return SingleChildScrollView(
                    child: Container(
                      margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                      child: Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 0),
                                  child: Text(
                                    'মোট গরুর পরিমান ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 0),
                                  child: Text(
                                    '${productController.productList.value.totalCattleCount ?? 0}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 5),
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 0),
                                  child: Text(
                                    'মোট বাছুরের পরিমান ',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  margin: EdgeInsets.only(top: 0),
                                  child: Text(
                                    '${productController.productList.value.totalCalvesCount ?? 0}',
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(fontSize: 20, color: Colors.black, fontWeight: FontWeight.bold),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Container(margin: EdgeInsets.only(top: 0, left: 5, right: 5, bottom: 5), child: Divider()),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ScrollPhysics(),
                            itemCount: productController.dataList.length,
                            itemBuilder: (context, index) {
                              return Card(
                                margin: EdgeInsets.zero,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        children: [
                                          Flexible(
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Container(
                                                    alignment: Alignment.centerLeft,
                                                    margin: EdgeInsets.only(top: 0),
                                                    child: Text(
                                                      'ফার্মের নাম: ${productController.dataList[index].name}',
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.black,
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      'গরুর পরিমান: ${productController.dataList[index].cattleCount.toString()}',
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      'বাছুরের পরিমান : ${productController.dataList[index].calvesCount.toString()}',
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
                                    ],
                                  ),
                                ),
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
        );
      }),
    );
  }

  void setCattleData() {
    if (selectedFarms == null) {
      Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
    } else if (selectedDivisionId == null) {
      Common.setWrongToast('বিভাগ নির্বাচন করুন');
    } else if (selectedZilaId == null) {
      Common.setWrongToast('জেলা নির্বাচন করুন');
    } else if (selectedUpaZilaId == null) {
      Common.setWrongToast('থানা নির্বাচন করুন!');
    } else {
      productController.fetchReportFarms(selectedDivisionId!, selectedZilaId!, selectedUpaZilaId!, farmsId: selectedFarms!);
    }
  }
}
