import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/local/shared_data.dart';
import 'package:food_app/model/register_model.dart';
import 'package:food_app/screens/otp_screen.dart';
import 'package:food_app/session/key_text.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/static_text.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool loader = false;
  bool isSelcted = false;

  final TextEditingController emailOrPhone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final GlobalKey<FormState> key = GlobalKey<FormState>();

  void initialize() async {
    if (await SharedPref.getPrefarance(REMEMBER_ME) == "true") {
      isSelcted = true;
      emailOrPhone.text = (await SharedPref.getPrefarance(EMAILOR_PHONE))!;
      password.text = (await SharedPref.getPrefarance(PASSWORD))!;
    } else {
      isSelcted = false;
    }
    setState(() {});
  }



  @override
  void initState() {
    initialize();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BG_COLOR,
        title: Text("Login"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28, top: 100),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your email or phone";
                      }
                    },
                    controller: emailOrPhone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14),
                        border: InputBorder.none,
                        hintText: "Email Or Phone",
                        labelText: "Email Or Phone"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0, right: 28, top: 20),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Please enter your password";
                      }
                    },
                    controller: password,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14),
                        border: InputBorder.none,
                        hintText: "Password",
                        labelText: "Password"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Row(
                  children: [
                    Checkbox(
                      activeColor: Colors.indigo,
                      value: isSelcted,
                      onChanged: (value) {
                        setState(() {
                          isSelcted = value!;
                         SharedPref.savePrefarance(REMEMBER_ME,
                              value.toString());
                          print("Value__$isSelcted");
                        });
                      },
                    ),
                    // 01643376085
                    InkWell(
                      onTap: (){
                        setState(() {
                          isSelcted = !isSelcted;
                        });
                      },
                      child: Text(
                        "Remember me",
                        style: TextStyle(fontSize: 18, color: Colors.black),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
              loader
                  ? Center(
                      child: CircularProgressIndicator(
                        color: Colors.indigo,
                      ),
                    )
                  : isSelcted == true
                      ? InkWell(
                          onTap: () {
                            if (key.currentState!.validate()) {
                              login();
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 28.0, right: 28),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 45,
                              width: double.infinity,
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            if (key.currentState!.validate()) {
                              login();
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 28.0, right: 28),
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              height: 45,
                              width: double.infinity,
                              child: Text(
                                "Log in",
                                style: TextStyle(
                                    fontSize: 18, color: Colors.white),
                              ),
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }

  Future login() async {
    setState(() {
      loader = true;
    });

    var body = {
      "email": "${emailOrPhone.text}",
      "password": "${password.text}",
    };
    print("Body ___$body");

    var response = await http.post(
      Uri.parse("https://bdraj.com/api/v2/auth/login"),
      body: body,
      headers: {"Accept": "application/json"},
    );

    if (response.statusCode == 200) {
      var jsondata = jsonDecode(response.body);
      if (isSelcted) {
        SharedPref.savePrefarance(EMAILOR_PHONE, emailOrPhone.text);
        SharedPref.savePrefarance(PASSWORD, password.text);
      }
      log(response.body);

      if (jsondata["result"] == false) {
        Fluttertoast.showToast(
            msg: "${jsondata["message"]}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
        setState(() {
          loader = false;
        });
      } else {
        setState(() {
          loader = false;
          Fluttertoast.showToast(
              msg: "${jsondata["message"]}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0);
          if (isSelcted) {
            SharedPref.savePrefarance(EMAILOR_PHONE, emailOrPhone.text);
            SharedPref.savePrefarance(PASSWORD, password.text);
            SharedPref.savePrefarance(TOKEN, jsondata['access_token'].toString());
          }

          // // SharedPref().SetAuthToken(jsondata['access_token']);
          // SharedPref.setEmailOrPhone(jsondata["user"]['phone']);
          // SharedPref().setPassword(password.text);
          // // SharedPref().rememberMe(isSelcted);

          Get.to(HomeScreen());

          print("response__${response.body}");
        });
      }
    } else {
      setState(() {
        loader = false;
      });
    }
  }
}
