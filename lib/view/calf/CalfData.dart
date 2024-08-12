import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';
import 'package:prani_sheba/main.dart';
import 'package:prani_sheba/model/CalfBirthProblem.dart';
import 'package:prani_sheba/model/CattleData.dart';
import 'package:prani_sheba/model/FarmsData.dart';
import 'package:prani_sheba/services/NetworkServices.dart';
import 'package:prani_sheba/view/HomePage.dart';
import 'package:prani_sheba/view/auth/Login_page.dart';
import 'package:prani_sheba/widget/CustomDialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class CalfData extends StatefulWidget {
  static const routeName = 'calf_data';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CalfData> {
  late File _image;
  final picker = ImagePicker();
  TextEditingController calfNameCon = TextEditingController();
  List<String> _calfGender = ['এঁড়ে বাছুর', 'বকনা'];
  List<String> _calfWeight = [
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
  List<String> _yesNoList = ['হ্যা', 'না'];

  late String selectedFarms,
      selectedCattleId,
      selectedCalfGender,
      selectedCalfWeight,
      selectedTag;

  DateTime selectedDate = DateTime.now();
  DateTime selectedDate2 = DateTime.now();
  TextEditingController _date2 = new TextEditingController();

  Future<Null> _selectDate2(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate2,
        firstDate: DateTime(1901, 1),
        lastDate: DateTime(2500));
    if (picked != null && picked != selectedDate2)
      setState(() {
        selectedDate2 = picked;

        DateFormat dateFormat = DateFormat("yyyy-MM-dd");
        String string = dateFormat.format(selectedDate2);
        _date2.value = TextEditingValue(text: string);
      });
  }

  Future _getImage(BuildContext context) async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        Get.snackbar('No image selected', '');
      }
    });
  }

  var calfBirthProblemChecked = [];

  var userStatusDisHistory = [];
  Future<List<CalfBirthProblem>> _getCalfBirthProblem() async {
    List<CalfBirthProblem> cattle = [];
    for (var u in calfBirthProblemToList!) {
      CalfBirthProblem heath = CalfBirthProblem(u.id, u.name);

      cattle.add(heath);
      userStatusDisHistory.add(false);
    }
    return cattle;
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
        title: Text('বাছুর সংক্রান্ত তথ্য'),
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
                            selectedFarms = newValue!;
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
                    child: Text(
                      "গাভীর নাম‌",
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
                            selectedCattleId = newValue!;
                          });
                          print(selectedCattleId);
                        },
                        items: cattleToList!.map((CattleData map) {
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
            Container(
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: TextField(
                  textAlign: TextAlign.start,
                  controller: calfNameCon,
                  autofocus: false,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'বাছুরের নাম',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 16),
                  )),
            ),
            Container(
              margin: EdgeInsets.only(top: 0, left: 15, right: 12),
              child: GestureDetector(
                  onTap: () {
                    _selectDate2(context);
                  },
                  child: AbsorbPointer(
                    child: TextField(
                      controller: _date2,
                      keyboardType: TextInputType.datetime,
                      decoration: InputDecoration(
                        labelText: 'বাছুর হওয়ার তারিখ (yyyy-MM-dd)',
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
                      'বাছুরের লিঙ্গ',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedCalfGender,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCalfGender = newValue!;
                          });
                          print(selectedCalfGender);
                        },
                        items: _calfGender.map((location) {
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
                      'বাছুরের ওজন',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedCalfWeight,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedCalfWeight = newValue!;
                          });
                          print(selectedCalfWeight);
                        },
                        items: _calfWeight.map((location) {
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
                      'বাছুরটির কি এয়ার ট্যাগ হয়েছে?',
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.grey, fontSize: 16),
                    ),
                  ),
                  Container(
                    child: DropdownButtonHideUnderline(
                      child: DropdownButton<String>(
                        hint: Text("নির্বাচন করুন"),
                        value: selectedTag,
                        isDense: true,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedTag = newValue!;
                          });
                          print(selectedTag);
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
              margin: EdgeInsets.only(top: 15, left: 15, right: 12),
              alignment: Alignment.centerLeft,
              child: Text(
                'বাছুরটি জন্মের সময় কোনো জন্মগত রোগ ছিল?',
                textAlign: TextAlign.start,
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            Container(
              child: FutureBuilder(
                future: _getCalfBirthProblem(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  print(snapshot.data);
                  if (snapshot.data == null) {
                    return Container(child: Center(child: Text("Loading...")));
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
                                    calfBirthProblemChecked
                                        .add(snapshot.data[index].id);
                                    print(calfBirthProblemChecked.toList());
                                  } else {
                                    calfBirthProblemChecked
                                        .remove(snapshot.data[index].id);
                                    print(calfBirthProblemChecked.toList());
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
              width: double.infinity,
              margin: EdgeInsets.only(top: 15, left: 15, right: 12),
              child: Card(
                child: Column(
                  children: [
                    /* Container(
                         alignment: Alignment.centerRight,
                         margin: EdgeInsets.only(top: 8,right: 10),
                         child: IconButton(
                             icon: Icon(Icons.camera_alt),
                             iconSize: 20.0,
                             onPressed: () {
                              _getImage();
                             })
                     ),
                      Container(
                          margin: EdgeInsets.only(left: 5,bottom: 1,right: 5),
                          width: double.infinity, height: 180,
                       child: _image == null ? Container(alignment: Alignment.center,child: Icon(Icons.add)) :  Image.file(
                         _image, fit: BoxFit.cover, )
                      ),*/
                    GestureDetector(
                      child: Container(
                        margin: EdgeInsets.only(top: 10, left: 5, right: 5),
                        width: double.infinity,
                        height: 180,
                        child: _image == null
                            ? Container(
                                alignment: Alignment.center,
                                child: Icon(Icons.add))
                            : Image.file(
                                _image,
                                fit: BoxFit.cover,
                              ),
                      ),
                      onTap: () {
                        _getImage(context);
                      },
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 10, bottom: 10),
                      child: Text(
                        'Calf Image',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
                    'জমা দিন',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15.0, color: Colors.white),
                  ),
                  padding:
                      EdgeInsets.symmetric(horizontal: 10.0, vertical: 12.0),
                ),
                onPressed: () {
                  setCattleData(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void setCattleData(BuildContext context) {
    //cattleNameCon.text = prefs.getString('token').toString();
    if (selectedFarms == null) {
      Common.setWrongToast('ফার্মের নাম নির্বাচন করুন!');
    } else if (selectedCattleId == null) {
      Common.setWrongToast('গাভী/দামড়া নাম নির্বাচন করুন');
    } else if (calfNameCon.text.length == 0) {
      Common.setWrongToast('বাছুরের নাম প্রদান করুন');
    } else if (_date2.text.length == 0) {
      Common.setWrongToast('বাছুর হওয়ার তারিখ প্রদান করুন');
    } else if (selectedCalfGender == null) {
      Common.setWrongToast('বাছুরের লিঙ্গ নির্বাচন করুন');
    } else if (selectedCalfWeight == null) {
      Common.setWrongToast('বাছুরের ওজন নির্বাচন করুন');
    } else if (selectedTag == null) {
      Common.setWrongToast('বাছুরটির কি এয়ার ট্যাগ হয়েছে নির্বাচন করুন');
    } else {
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => Customdialog());

      setState(() {
        dataPush(context);
      });
    }
  }

  void dataPush(BuildContext context) async {
    var stream = new http.ByteStream(DelegatingStream(_image.openRead()));
    // get file length
    var length = await _image.length(); //imageFile is your image file
    Map<String, String> headers = headersToken; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse(NetworkServices.baseUrl + 'form/store-calf');

    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = new http.MultipartFile('image', stream, length,
        filename: basename(_image.path));

    // add file to multipart
    request.files.add(multipartFileSign);

    //add headers
    request.headers.addAll(headers);

    //adding params
    request.fields["farm_id"] = selectedFarms;
    request.fields["cattle_id"] = selectedCattleId;
    request.fields["tag"] = selectedTag;
    request.fields["name"] = calfNameCon.text;
    request.fields["birth_date"] = _date2.text;
    request.fields["gender"] = selectedCalfGender;
    request.fields["weight"] = selectedCalfWeight;
    request.fields["calf_birth_problem_ids"] =
        calfBirthProblemChecked.toList().toString();

    // send
    var response = await request.send();

    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);

      switch (response.statusCode) {
        case 200:
          Navigator.of(context).pushNamedAndRemoveUntil(
              HomePage.routeName,
                  (Route<dynamic> route) => false);
          Common.setRightToast('আপনার তথ্য গুলো সঠিক ভাবে জমা হয়েছে।',);
          break;
        case 401:
          Common.setWrongToast('আপনি আবার লগইন করুন!');
          Navigator.of(context).pushNamedAndRemoveUntil(
              Login_page.routeName, (Route<dynamic> route) => false);
          break;

        default:
          Navigator.pop(context, true);
          Common.setWrongToast(value.toString());
          break;
      }
    });
  }

  void dataInsertSuccess(BuildContext context) async {
    Alert(
      context: context,
      type: AlertType.success,
      closeFunction: () {
        Navigator.of(context).pushNamedAndRemoveUntil(
            HomePage.routeName, (Route<dynamic> route) => false);
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
                  HomePage.routeName, (Route<dynamic> route) => false);
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
