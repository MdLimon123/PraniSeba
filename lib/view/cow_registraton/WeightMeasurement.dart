import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'package:prani_sheba/Common/Helper.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/model/FarmsToCattle.dart';
import 'package:prani_sheba/model/Productions.dart';
import 'package:prani_sheba/services/NetworkServices.dart';
import 'package:prani_sheba/view/auth/Login_page.dart';
import 'package:prani_sheba/view/cow_registraton/CowRegistrationHome.dart';
import 'package:prani_sheba/widget/CustomDialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../HomePage.dart';

class WeightMeasurement extends StatefulWidget {
  static const routeName = 'weight_measurement';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<WeightMeasurement> {
  List<TextEditingController> _controllers = [];
  String? selectedFarms, selectedCattleGender;

  DateTime selectedDate = DateTime.now();
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

        DateFormat dateFormat = DateFormat('yyyy-MM-dd');
        String string = dateFormat.format(selectedDate);
        _date.value = TextEditingValue(text: string);
      });
  }

  List<FarmsToCattle> cattleFarmsList = [];
  Future _getCattleSpData(BuildContext context, int id) async {
    cattleFarmsList.clear();
    FarmsToCattle catFarms;
    for (int i = 0; i < cattleToList!.length; i++){
      int farmsId = cattleToList![i].farmId!;
      if(farmsId == id){
        //  Fluttertoast.showToast(msg: cattleToList[i].name);
        print(cattleToList![i].name);
        catFarms = FarmsToCattle();
        catFarms.id = cattleToList![i].id;
        catFarms.farmId = cattleToList![i].farmId;
        catFarms.name = cattleToList![i].name;
        catFarms.tag = cattleToList![i].tag;
        cattleFarmsList.add(catFarms);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
        title: Text('ওজন পরিমাপ'),
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
                            var id  = int.parse(selectedFarms!);
                            assert(id is int);
                            _getCattleSpData(context,id);
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
              //_selectedLastDay
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
                        labelText: 'ওজন পরিমাপের তারিখ (dd-mm-yyyy)',
                      ),
                    ),
                  )),
            ),
            ListView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: cattleFarmsList.length,

                itemBuilder: (BuildContext context, int index) {
                  _controllers.add(new TextEditingController());
                  return Container(
                    width: double.infinity,
                    height: 70,
                    margin: EdgeInsets.only(left: 8, right: 8, top: 5, bottom: 5),
                    child: Row(
                      children: <Widget>[
                        Image.asset('assets/images/cow_icon.png', width: 70, height: 70, fit: BoxFit.cover,),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children:  <Widget>[
                            Container(
                                width: 120,
                                margin: EdgeInsets.only(left: 15,right: 5,top: 5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '${cattleFarmsList[index].name}', maxLines: 1,
                                  textAlign: TextAlign.start,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(fontSize: 16, color: Colors.black,),
                                )
                            ),
                            Container(
                                width: 100,
                                margin: EdgeInsets.only(left: 0,right: 5,top: 5),
                                alignment: Alignment.centerLeft,
                                child: Text('ট্যাগ: ${cattleFarmsList[index].tag}',
                                  style: TextStyle(fontSize: 14, color: Colors.grey,),
                                )
                            ),
                          ],
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                width: 40,
                                height: 40,
                                child: TextField(
                                  textAlign: TextAlign.start,
                                  controller:   _controllers[index],
                                  autofocus: false,
                                  keyboardType: TextInputType.phone,
                                ),
                              ),
                              Text('kg',
                                style: TextStyle(fontSize: 14, color: Colors.grey,),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                }
            ),
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 20, right: 12),
              alignment: Alignment.centerRight,
              child: ElevatedButton(
               style: ElevatedButton.styleFrom(
                 textStyle: TextStyle(
                   color: Colors.white
                 )
               ),
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
                onPressed: (){
                  setCattleData();
                },),
            ),
          ],
        ),
      ),
    );
  }

  void setCattleData() {
    if (selectedFarms == null) {
      Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
    } else if (_date.text.length == 0) {
      Common.setWrongToast('ওজন পরিমাপের তারিখ প্রদান করুন');
    }
    else {
      for(int i= 0; i < cattleFarmsList.length; i++){
        if(_controllers[i].text.length == 0){

        }else{
          showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => Customdialog());

          setState(() {
            dataPush();
          });
        }
      }
    }
  }

  void dataPush() async {
    int value;
    int id;
    var pro;
    for(int i= 0; i < cattleFarmsList.length; i++){
      value = int.parse(_controllers[i].text);
      assert(value is int);
      id = cattleFarmsList[i].id!;
      pro = [Production(cattleId: id,value: value).toJson()];
    }
    int farm = int.parse(selectedFarms!);
    assert(farm is int);

    var body = {
      "token": prefs!.getString('token').toString(),
      "farm_id": selectedFarms,
      "date": _date.text,
      "weights": json.encode(pro)
    };
    http.Response response =
    await http.post(Uri.parse(NetworkServices.baseUrl + 'form/store-weight-info'), body: body,
        headers: headersToken);

    print(response.statusCode);
    print(response.body);
    final responseJson = json.decode(response.body);
    String data = responseJson['error'];
    switch (response.statusCode) {
      case 200:
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomePage.routeName,
                (Route<dynamic> route) => false);
        Common.setRightToast('আপনার তথ্য গুলো সঠিক ভাবে জমা হয়েছে।',);
        break;
      case 401:
        Common.setWrongToast('আপনি আবার লগইন করুন!');
        Navigator.of(context).pushReplacementNamed(
            Login_page.routeName,);
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
        Navigator.of(context).pushReplacementNamed(
            CowRegistrationHome.routeName,);
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
  }
}
