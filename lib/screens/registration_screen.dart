import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:food_app/model/register_model.dart';
import 'package:food_app/screens/otp_screen.dart';
import 'package:food_app/utils/colors.dart';
import 'package:food_app/utils/static_text.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart'as http;
class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {

  RegisterModel ? _registerModel;
  bool loader = false;
  String ? registerBy;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailOrPhone = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final GlobalKey<FormState>  key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: BG_COLOR,
        title: Text(REGISTRIONTEXT),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            children: [

              Padding(
                padding: const EdgeInsets.only(left: 28.0,right: 28,top: 100),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child: TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your name";
                      }
                    },
                    controller: nameController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 14),
                      border: InputBorder.none,
                      hintText: "Name",
                      labelText: "Name"
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0,right: 28,top: 20),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child:  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your phone or email";
                      }
                    },
                    controller: emailOrPhone,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14),
                        border: InputBorder.none,
                        hintText: "Email or Phone",
                        labelText: "Email or phone"
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0,right: 28,top: 20),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child:  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your password";
                      }
                    },
                    controller: password,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14),
                        border: InputBorder.none,
                        hintText: "Password",
                        labelText: "Password"
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 28.0,right: 28,top: 20),
                child: Card(
                  color: Colors.white,
                  elevation: 2,
                  child:  TextFormField(
                    validator: (value){
                      if(value!.isEmpty){
                        return "Please enter your confirm password";
                      }
                    },
                    controller: confirmPassword,
                    decoration: InputDecoration(
                        contentPadding: EdgeInsets.only(left: 14),
                        border: InputBorder.none,
                        hintText: "Confirm Password",
                        labelText: "Confirm Password"
                    ),
                  ),
                ),
              ),


              SizedBox(height: 30,),


           loader ? Center(child: CircularProgressIndicator(
             color: Colors.indigo,
           ),) :
           InkWell(
                onTap: (){
                  if(key.currentState!.validate()){
                    register();

                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 28.0,right: 28),
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.indigo,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    height: 45,
                    width: double.infinity,
                    child: Text("Sign up",style: TextStyle(
                      fontSize: 18,color: Colors.white
                    ),),

                  ),
                ),
              ),




            ],
          ),
        ),
      ),
    );
  }


  Future<RegisterModel?>  register()async{
    setState(() {
      loader = true;
    });
    if(emailOrPhone.text.contains("@")){
      registerBy = "email";
    }else{
      registerBy = "phone";
    }


    var body = {
      "name" : "${nameController.text}",
      "email_or_phone" : "${emailOrPhone.text}",
      "password" : "${password.text}",
      "password_confirmation" : "${confirmPassword.text}",
      "register_by" : "${registerBy}",
    };
    print("Body ___$body");

    var response = await http.post(Uri.parse("https://bdraj.com/api/v2/auth/signup"),
    body: body,
      headers: {
      "Accept" : "application/json"
      },
    );
    _registerModel = registerModelFromJson(response.body);

    if(response.statusCode==201){

      if(_registerModel!.result==false){
        Fluttertoast.showToast(
            msg: "${_registerModel!.message.toString()}",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
        setState(() {
          loader = false;
        });

      }else{

        setState(() {
          loader = false;
          Fluttertoast.showToast(
              msg: "${_registerModel!.message.toString()}",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.CENTER,
              timeInSecForIosWeb: 1,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

          Get.to(OTPScreen(userId: _registerModel!.userId!,));

          print("response__${response.body}");

        });
      }

    }else{
      setState(() {
        loader = false;
      });
    }
    return _registerModel;

  }
  
  
}
