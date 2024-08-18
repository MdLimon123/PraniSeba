import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:prani_sheba/common/Common.dart';
import 'package:prani_sheba/common/CommonColor.dart';
import 'package:prani_sheba/common/Helper.dart';

import 'package:prani_sheba/services/NetworkServices.dart';
import 'package:prani_sheba/view/auth/Login_page.dart';
import 'package:prani_sheba/view/cow_registraton/CowRegistrationHome.dart';
import 'package:prani_sheba/widget/CustomDialog.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../HomePage.dart';

class CowImageUpload extends StatefulWidget {
  static const routeName = 'cow_image_upload';

  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CowImageUpload> {
   File? _image, _imageFront2, _imageLeft, _imageLeft2, _imageRight, _imageRight2, _imageBack, _imageBack2;
  final picker = ImagePicker();

  Future _getImage(BuildContext context, ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if(pickedFile != null){
        _image = File(pickedFile.path);
      }else{
        Get.snackbar('No image selected', '');
      }
    });
  }

  Future _getImageFort2(BuildContext context, ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if(pickedFile != null){
        _imageFront2 = File(pickedFile.path);
      }else{
        Get.snackbar('No image selected', '');
      }
    });
  }

  Future _getImageLeft(BuildContext context, ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if(pickedFile != null){
        _imageLeft = File(pickedFile.path);
      }else{
        Get.snackbar('No image selected', '');
      }
    });
  }

  Future _getImageLeft2(BuildContext context, ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if(pickedFile != null){
        _imageLeft2 = File(pickedFile.path);
      }else{
        Get.snackbar('No image selected', '');
      }
    });
  }

  Future _getImageRight(BuildContext context, ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if(pickedFile != null){
        _imageRight = File(pickedFile.path);
      }else{
        Get.snackbar('No image selected', '');
      }
    });
  }

  Future _getImageRight2(BuildContext context, ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if(pickedFile != null){
        _imageRight2 = File(pickedFile.path);
      }else{
        Get.snackbar('No image selected', '');
      }
    });
  }

  Future _getImageBack(BuildContext context, ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if(pickedFile != null){
        _imageBack = File(pickedFile.path);
      }else{
        Get.snackbar('No image selected', '');
      }
    });
  }

  Future _getImageBack2(BuildContext context, ImageSource source) async{
    final pickedFile = await picker.pickImage(source: source);
    setState(() {
      if(pickedFile != null){
        _imageBack2 = File(pickedFile.path);
      }else{
        Get.snackbar('No image selected', '');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
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
              Center(
                child: Container(
                  margin: EdgeInsets.only(top: 15, left: 15, right: 12),
                  child: Text(
                    'Need to upload cow picture',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color:
                            Color(Helper.getHexToInt(CommonColor.primaryColor)),
                        fontSize: 18),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImage(context,ImageSource.camera);
                                      })
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImage(context,ImageSource.gallery);
                                      })
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: Container(
                          child: _image != null
                              ?  Image.file(
                            _image!, fit: BoxFit.fill, )
                              : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.photo_camera,size: 100, color: Colors.grey,),
                              ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text(
                          'Cow Front Image 1',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageFort2(context,ImageSource.camera);
                                      })
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageFort2(context,ImageSource.gallery);
                                      })
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: Container(
                          child: _imageFront2 != null
                              ?  Image.file(
                            _imageFront2!, fit: BoxFit.fill, )
                              : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.photo_camera,size: 100, color: Colors.grey,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text(
                          'Cow Front Image 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageLeft(context,ImageSource.camera);
                                      })
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageLeft(context,ImageSource.gallery);
                                      })
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: Container(
                          child: _imageLeft != null
                              ?  Image.file(
                            _imageLeft!, fit: BoxFit.fill, )
                              : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.photo_camera,size: 100, color: Colors.grey,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text(
                          'Cow Left Image 1',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageLeft2(context,ImageSource.camera);
                                      })
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageLeft2(context,ImageSource.gallery);
                                      })
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: Container(
                          child: _imageLeft2 != null
                              ?  Image.file(
                            _imageLeft2!, fit: BoxFit.fill, )
                              : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.photo_camera,size: 100, color: Colors.grey,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text(
                          'Cow Left Image 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageRight(context,ImageSource.camera);
                                      })
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageRight(context,ImageSource.gallery);
                                      })
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: Container(
                          child: _imageRight != null
                              ?  Image.file(
                            _imageRight!, fit: BoxFit.fill, )
                              : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.photo_camera,size: 100, color: Colors.grey,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text(
                          'Cow Right Image 1',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageRight2(context,ImageSource.camera);
                                      })
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageRight2(context,ImageSource.gallery);
                                      })
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: Container(
                          child: _imageRight2 != null
                              ?  Image.file(
                            _imageRight2!, fit: BoxFit.fill, )
                              : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.photo_camera,size: 100, color: Colors.grey,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text(
                          'Cow Right Image 2',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageBack(context,ImageSource.camera);
                                      })
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageBack(context,ImageSource.gallery);
                                      })
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: Container(
                          child: _imageBack != null
                              ?  Image.file(
                            _imageBack!, fit: BoxFit.fill, )
                              : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.photo_camera,size: 100, color: Colors.grey,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text(
                          'Cow Back Image 1',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsets.only(top: 15, left: 10, right: 10),
                child: Card(
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera_alt),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageBack2(context,ImageSource.camera);
                                      })
                              ),
                              Container(
                                  alignment: Alignment.centerRight,
                                  margin: EdgeInsets.only(right: 5),
                                  child: IconButton(
                                      icon: Icon(Icons.camera),
                                      iconSize: 25.0,
                                      onPressed: () {
                                        _getImageBack2(context,ImageSource.gallery);
                                      })
                              ),
                            ]),
                      ),
                      Container(
                        width: double.infinity,
                        height: 250,
                        child: Container(
                          child: _imageBack2 != null
                              ?  Image.file(
                            _imageBack2!, fit: BoxFit.fill, )
                              : Container(
                            alignment: Alignment.center,
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.photo_camera,size: 100, color: Colors.grey,),
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10,bottom: 10),
                        child: Text(
                          'Cow Back Image 2',
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
                    //send server cattle info
                    setCattleData(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setCattleData(BuildContext context) {
    if (_image == null) {
      Common.setWrongToast('Cow Front Image 1 প্রদান করুন!');
    }  if (_imageFront2 == null) {
      Common.setWrongToast('Cow Front Image 2 করুন!');
    } if (_imageLeft == null) {
      Common.setWrongToast('Cow Left Image 1 প্রদান করুন!');
    } if (_imageLeft2 == null) {
      Common.setWrongToast('Cow Left Image 2 প্রদান করুন!');
    } if (_imageRight == null) {
      Common.setWrongToast('Cow Right Image 1 প্রদান করুন!');
    } if (_imageRight2 == null) {
      Common.setWrongToast('Cow Right Image 2 প্রদান করুন!');
    } if (_imageBack == null) {
      Common.setWrongToast('Cow Back Image 1 প্রদান করুন!');
    } if (_imageBack2 == null) {
      Common.setWrongToast('Cow Back Image 2 প্রদান করুন!');
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
    /*http.Response response =
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
    }*/

    var stream = http.ByteStream(DelegatingStream(_image!.openRead()));
    var front_image_2stream = http.ByteStream(DelegatingStream(_imageFront2!.openRead()));
    var lefStream = http.ByteStream(DelegatingStream(_imageLeft!.openRead()));
    var lef2Stream = http.ByteStream(DelegatingStream(_imageLeft2!.openRead()));
    var rightStream = http.ByteStream(DelegatingStream(_imageRight!.openRead()));
    var right2Stream = http.ByteStream(DelegatingStream(_imageRight2!.openRead()));
    var backStream = http.ByteStream(DelegatingStream(_imageBack!.openRead()));
    var back2Stream = http.ByteStream(DelegatingStream(_imageBack2!.openRead()));
    // get file length
    var length = await _image!.length(); //imageFile is your image file
    var front_image_2length = await _imageFront2!.length(); //imageFile is your image file
    var leftLength = await _imageLeft!.length(); //imageFile is your image file
    var left2Length = await _imageLeft2!.length(); //imageFile is your image file
    var rightLength = await _imageRight!.length(); //imageFile is your image file
  var right2Length = await _imageRight2!.length(); //imageFile is your image file
    var backLength = await _imageBack!.length(); //imageFile is your image file
    var back2Length = await _imageBack2!.length(); //imageFile is your image file
    Map<String, String> headers = headersToken; // ignore this headers if there is no authentication

    // string to uri
    var uri = Uri.parse(NetworkServices.baseUrl + 'form/store-cattle');
    // create multipart request
    var request = new http.MultipartRequest("POST", uri);

    // multipart that takes file
    var multipartFileSign = new http.MultipartFile('front_image_1', stream, length, filename: basename(_image!.path));
    var front_image_2file = new http.MultipartFile('front_image_2', front_image_2stream, front_image_2length, filename: basename(_imageFront2!.path));
    var lefFile = new http.MultipartFile('left_image_1', lefStream, leftLength, filename: basename(_imageLeft!.path));
    var left2File = new http.MultipartFile('left_image_2', lef2Stream, left2Length, filename: basename(_imageLeft2!.path));
    var rightFile = new http.MultipartFile('right_image_1', rightStream, rightLength, filename: basename(_imageRight!.path));
    var right2File = new http.MultipartFile('right_image_2', right2Stream, right2Length , filename: basename(_imageRight2!.path));
    var backFile = new http.MultipartFile('back_image_1', backStream, backLength, filename: basename(_imageBack!.path));
    var back2File = new http.MultipartFile('back_image_2', back2Stream, back2Length, filename: basename(_imageBack2!.path));
    // add file to multipart
    request.files.add(multipartFileSign);
    request.files.add(front_image_2file);
    request.files.add(lefFile);
    request.files.add(left2File);
    request.files.add(rightFile);
    request.files.add(right2File);
    request.files.add(backFile);
    request.files.add(back2File);

    //add headers
    request.headers.addAll(headers);
    //adding params
    request.fields["farm_id"] = Common.selectedFarms!;
    request.fields["tag"] = Common.tagIdCon!;
    request.fields["name"] = Common.cattleNameCon!;
    request.fields["cattle_group_id"] = Common.selectedCattleGroup!;
    request.fields["cattle_breed_id"] = Common.selectedCattleBreed!;
    request.fields["birth_date"] = Common.dateBirthDay!;
    request.fields["weight"] = Common.weightCon!;
    request.fields["gender"] = Common.selectedCattleGender!;
    request.fields["health_problem"] = Common.selectedHealthInfo!;
    request.fields["avg_milk_production"] = Common.selectedAvrMilkManufacture!;
    request.fields["milk_production_status"] = Common.selectedDhuddhonYsno!;
    request.fields["calf_count"] = Common.selectedCattleCount!;
    request.fields["last_calf_birth_date"] = Common.dateLastDay!;
    request.fields["genetic_percentage"] = Common.selectedGeneticPercentage!;
    request.fields["insurance_company_id"] = Common.selectedInsuranceCompany!;
    request.fields["insurance_no"] = Common.insuranceNumberCon!;
    request.fields["insurance_type_id"] = Common.selectedInsuranceType!;
    request.fields["disease_history_ids"] = Common.diseaseHistoryChecked!;
    request.fields["health_info_ids"] = Common.healthInfoChecked!;

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
            CowRegistrationHome.routeName, (Route<dynamic> route) => false);
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
