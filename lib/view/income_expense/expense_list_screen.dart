import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/custom_app_bar.dart';
import 'package:prani_sheba/common/style_data.dart';
import 'package:prani_sheba/controller/ReportMilkProductinController.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/ExpenseAccountData.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/IncomeAccountData.dart';

class ExpenseListScreen extends StatefulWidget {
  static const routeName = 'expense_list';

  _ReportPregnant createState() => _ReportPregnant();
}

class _ReportPregnant extends State<ExpenseListScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();

  final ReportMilkProductinController productController =
      Get.put(ReportMilkProductinController());
  String? selectedFarms, selectedIncomeAccountName;
  String _dateBirthDay = '';
  String _dateLastDay = '';
  bool accountVisibility = true;
  bool accountStatus = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: CustomAppBar(title: 'ব্যায়ের তালিকা'),
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
                      "খামারের নাম‌",
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
                            ? incomeAccountToList!.map((IncomeAccountData map) {
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
            Container(
                margin: EdgeInsets.only(top: 0, left: 15, right: 12),
                child: Divider()),

            size15,
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      _dateBirthDay =
                          await selectDate(context, date: _dateBirthDay);
                      setState(() {});
                    },
                    child: Column(
                      children: [
                        Text('শুরুর তারিখ (yyyy-MM-dd)',
                            style:
                                TextStyle(fontSize: 12.5, color: Colors.grey)),
                        Row(
                          children: [
                            Expanded(
                                child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Text(_dateBirthDay),
                            )),
                            Icon(Icons.calendar_today_outlined,
                                color: Colors.grey, size: 18),
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
                      _dateLastDay =
                          await selectDate(context, date: _dateLastDay);
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
                            Icon(Icons.calendar_today_outlined,
                                color: Colors.grey, size: 20),
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
            Expanded(
              child: Obx(() {
                if (productController.isLoading.value)
                  return Center(child: CircularProgressIndicator());
                else
                  print("Total Products = " +
                      productController.dataList.length.toString());

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
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0),
                                child: Text(
                                  '${productController.productList.value.cattleCount.toString()}',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                            child: Divider()),
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
                        Container(
                            margin: EdgeInsets.only(top: 0, left: 0, right: 0),
                            child: Divider()),
                        Container(
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
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0),
                                child: Text(
                                  'Cow',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              ),
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: EdgeInsets.only(top: 0),
                                child: Text(
                                  'Quantity',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.black),
                                ),
                              )
                            ],
                          ),
                        ),
                        // ListView.builder(
                        //   shrinkWrap: true,
                        //   physics: ScrollPhysics(),
                        //   itemCount: productController.dataList.length,
                        //   itemBuilder: (context, index) {
                        //     _cattleData(productController.dataList[index].cattleId);
                        //     return Column(
                        //       children: [
                        //         Row(
                        //           children: [
                        //             Container(
                        //               width: 100,
                        //               height: 85,
                        //               margin: EdgeInsets.only(right: 10),
                        //               child: ClipRRect(
                        //                 borderRadius: BorderRadius.circular(0),
                        //                 child: cattleDataList[index].frontImage1 != null
                        //                     ? Image.network(
                        //                         '${NetworkServices.imageUrl + cattleDataList[index].frontImage1}',
                        //                         width: 100,
                        //                         height: 85,
                        //                         fit: BoxFit.fill,
                        //                         colorBlendMode: BlendMode.color,
                        //                       )
                        //                     : Image.asset(
                        //                         'assets/images/cow_icon.png',
                        //                         width: 100,
                        //                         height: 85,
                        //                         fit: BoxFit.fill,
                        //                         colorBlendMode: BlendMode.color,
                        //                       ),
                        //               ),
                        //             ),
                        //             Flexible(
                        //                 child: Row(
                        //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        //               crossAxisAlignment: CrossAxisAlignment.start,
                        //               children: [
                        //                 Container(
                        //                   margin: EdgeInsets.only(top: 5),
                        //                   child: Text(
                        //                     'গরুর নাম: ${cattleDataList[index].name}',
                        //                     textAlign: TextAlign.left,
                        //                     maxLines: 1,
                        //                     overflow: TextOverflow.ellipsis,
                        //                     style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                        //                   ),
                        //                 ),
                        //                 Container(
                        //                   margin: EdgeInsets.only(top: 5),
                        //                   child: Text(
                        //                     '${productController.dataList[index].value}',
                        //                     textAlign: TextAlign.left,
                        //                     maxLines: 1,
                        //                     overflow: TextOverflow.ellipsis,
                        //                     style: TextStyle(fontSize: 15, color: Colors.grey, fontStyle: FontStyle.normal),
                        //                   ),
                        //                 ),
                        //               ],
                        //             ))
                        //           ],
                        //         ),
                        //         Divider(
                        //           color: Colors.grey,
                        //         ),
                        //       ],
                        //     );
                        //   },
                        // )
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
    } else if (_dateBirthDay == '') {
      Common.setWrongToast('শুরুর তারিখ');
    } else if (_dateLastDay == '') {
      Common.setWrongToast('শেষ তারিখ');
    } else {}
  }
}
