import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/common/date_converter.dart';
import 'package:prani_sheba/controller/ReportVaccineCalenderController.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/FarmsToCattle.dart';
import 'package:prani_sheba/model/cattle_diseases.dart';
import 'package:prani_sheba/services/NetworkServices.dart';

class ReportVaccineCalenderPage extends StatefulWidget {
  static const routeName = 'report_vaccine_calender_page';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<ReportVaccineCalenderPage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final ReportVaccineCalenderController productController = Get.put(ReportVaccineCalenderController());
  String? selectedFarms, selectedCattleDiseaseId, selectedCattleId;

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
        title: Text('টিকার ক্যালেন্ডার'),
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
                      'টিকা',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedCattleDiseaseId,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCattleDiseaseId = newValue;
                          });
                          print(selectedCattleDiseaseId);
                        },
                        items: cattle_diseasesToList!.map((CattleDiseases map) {
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
                  ),
                ],
              ),
            ),
            Container(margin: EdgeInsets.only(top: 0, left: 15, right: 12), child: Divider()),
            customButtonSearch(onTap: () {
              setCattleData();
            }),

            //List view show
            Obx(() {
              if (productController.isLoading.value)
                return Container(child: Padding(padding: const EdgeInsets.only(top: 30), child: Text('No Data Found')));
              else
                return productController.dataList.length != 0
                    ? Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            margin: EdgeInsets.only(top: 0, left: 10, right: 10),
                            child: Column(
                              children: [
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
                                                      'দেওয়া হয়েছেঃ ${DateConverter.formatDateIOS(productController.dataList[index].date!)}',
                                                      textAlign: TextAlign.left,
                                                      maxLines: 1,
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: EdgeInsets.only(top: 5),
                                                    child: Text(
                                                      'মন্তব্যঃ ${productController.dataList[index].remark ?? "নাই"}',
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
    } else if (selectedCattleDiseaseId == null) {
      Common.setWrongToast('টিকা নির্বাচন করুন');
    } else {
      productController.fetchVaccineCalender(selectedFarms!, selectedCattleDiseaseId!);
    }
  }
}
