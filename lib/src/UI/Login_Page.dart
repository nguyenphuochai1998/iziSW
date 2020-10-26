import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_hair_aka/src/UI/Home_Page.dart';
import 'package:flutter_app_hair_aka/src/Utils/Network_Util.dart';

import 'package:shared_preferences/shared_preferences.dart';

NetworkUtil _netUtil = new NetworkUtil();

class LoginPage extends StatefulWidget {
  LoginPage({Key key}) : super(key: key);
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  GlobalKey<FormState> _key = new GlobalKey();
  bool checkBoxVal = false;
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: [
            Container(
              width: ScreenSize.width,
              height: ScreenSize.height,
              child: Image.asset(
                "assets/images/img2.jpg",
                fit: BoxFit.fill,
              ),
            ),

            // bang den
            Center(
                child: Container(
                    width: ScreenSize.width * 0.85,
                    height: ScreenSize.height * 0.65,
                    decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: new BorderRadius.all(Radius.circular(8))),
                    child: Padding(
                      padding: EdgeInsets.only(top: ScreenSize.height * 0.22),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              alignment: Alignment.center,
                              padding: const EdgeInsets.only(left: 20.0),
                              color: Colors.amber,
                              child: new TextFormField(
                                controller: _userController,
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  icon: const Icon(
                                    Icons.supervised_user_circle_rounded,
                                    color: Colors.white,
                                  ),
                                  labelText: 'Tên Đăng Nhập',
                                ),
                                keyboardType: TextInputType.number,
                                onSaved: (String value) {},
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: Container(
                              padding: const EdgeInsets.only(left: 20.0),
                              color: Colors.amber,
                              child: new TextFormField(
                                controller: _passController,
                                decoration: const InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  icon: const Icon(
                                    Icons.supervised_user_circle_rounded,
                                    color: Colors.white,
                                  ),
                                  labelText: 'Mật Khẩu',
                                ),
                                keyboardType: TextInputType.number,
                                onSaved: (String value) {},
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Container(
                                  width: 17,
                                  height: 17,
                                  color: Colors.white,
                                  child: Checkbox(
                                    activeColor: Colors.amber,
                                    value: checkBoxVal,
                                    onChanged: (_) {
                                      setState(() {
                                        checkBoxVal = !checkBoxVal;
                                      });
                                    },
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "Nhớ Mật Khẩu",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 19),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(10),
                            child: SizedBox(
                              width: ScreenSize.width * 0.55,
                              height: 65,
                              child: RaisedButton(
                                onPressed: () {
                                  onSignInClick();
                                },
                                child: Text(
                                  "Đăng Nhập",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 22),
                                ),
                                color: Color(0xffFFBB33),
                                shape: RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(2.0),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ))),
            // hinh tron
            Center(
              child: Container(
                alignment: Alignment.topCenter,
                width: ScreenSize.width * 0.85,
                height: ScreenSize.height * 0.85,
                child: Container(
                    child: Container(
                  width: 200.0,
                  height: 200.0,
                  decoration: new BoxDecoration(
                    color: Colors.orange,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Container(
                          width: 175.0,
                          height: 175.0,
                          decoration: new BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Container(
                              width: 172.0,
                              height: 172.0,
                              decoration: new BoxDecoration(
                                color: Colors.black,
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                child: CircleAvatar(
                                  minRadius: 50,
                                  backgroundImage:
                                      AssetImage('assets/images/logo.jpg'),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )),
              ),
            )
          ],
        ));
  }

  String generateMd5(String input) {
    return md5.convert(utf8.encode(input)).toString();
  }

  bool _validate = false;

  // login app
  void onSignInClick() {
    Firestore.instance.collection("Test").add({"test": "test"});

    print("phone:" + _userController.text + "pas" + _passController.text);
    Map param = {
      'what': 1408,
      'phone': _userController.text,
      'password': generateMd5(_passController.text)
    };
    var input = jsonEncode(param);
    _netUtil.get(input).then((dynamic res) async {
      if (res.length >0) {
        // save data to shared preferences
          _userController.clear();
          _passController.clear();

      } else {
        print("k dang nhap duoc");
    }
    }
    );
  }







}
