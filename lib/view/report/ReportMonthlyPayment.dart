import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/common/style_data.dart';
import 'package:prani_sheba/controller/ReportMonthlyPaymentController.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/FarmsData.dart';

class ReportMonthlyPayment extends StatefulWidget {
  static const routeName = 'report_monthly_payment';

  _ReportPregnant createState() => _ReportPregnant();
}

class _ReportPregnant extends State<ReportMonthlyPayment> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  String _dateBirthDay = '';
  String _dateLastDay = '';
  final ReportMonthlyPaymentController productController =
      Get.put(ReportMonthlyPaymentController());
  String? selectedFarms;

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
        title: Text('মাসিক পেমেন্ট'),
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
                                color: Colors.grey),
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
                                color: Colors.grey),
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
                  print("Total Products = " +
                      productController.dataList.length.toString());

                return Container(
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
                                'Total Income ',
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
                                '${productController.productList.value.totalIncome.toString()}',
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
                                'Total Expense ',
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
                                '${productController.productList.value.totalExpense.toString()}',
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
                        margin: EdgeInsets.only(top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: Alignment.centerLeft,
                              margin: EdgeInsets.only(top: 0),
                              child: Text(
                                'Balance',
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
                                '${productController.productList.value.balance.toString()}',
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
                      //List view show
                      Obx(
                        () {
                          if (productController.isLoading.value)
                            return Container(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 30),
                                child: Text(
                                  'No Data Found',
                                ),
                              ),
                            );
                          else
                            return productController.dataList.length != 0
                                ? Expanded(
                                    child: SingleChildScrollView(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            top: 0, left: 10, right: 10),
                                        child: Column(
                                          children: [
                                            ListView.builder(
                                              shrinkWrap: true,
                                              physics: ScrollPhysics(),
                                              itemCount: productController
                                                  .dataList.length,
                                              itemBuilder: (context, index) {
                                                return Column(
                                                  children: [
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            'সম্যঃ ${productController.dataList[index].date}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 5),
                                                          child: Text(
                                                            'পরিমানঃ ${productController.dataList[index].quantity ?? 0}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                            top: 5,
                                                          ),
                                                          child: Text(
                                                            'মোটঃ ${productController.dataList[index].totalAmount ?? 0}',
                                                            textAlign:
                                                                TextAlign.left,
                                                            maxLines: 1,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style: TextStyle(
                                                                fontSize: 15,
                                                                color:
                                                                    Colors.grey,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal),
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
                                : Container(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 30),
                                      child: Text(
                                        'No Data Found',
                                      ),
                                    ),
                                  );
                        },
                      ),
                    ],
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
    } else if (_dateBirthDay.length == 0) {
      Common.setWrongToast('শুরুর তারিখ প্রদান করুন!');
    } else if (_dateLastDay.length == 0) {
      Common.setWrongToast('শেষ তারিখ প্রদান করুন!');
    } else {
      productController.fetchReport(selectedFarms!, _dateBirthDay, _dateLastDay);
    }
  }
}
