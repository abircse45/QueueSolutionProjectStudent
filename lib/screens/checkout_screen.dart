import 'package:flutter/material.dart';
import 'package:food_app/screens/address_screen.dart';
import 'package:get/get.dart';

class CheckOutPage extends StatefulWidget {
  const CheckOutPage({Key? key}) : super(key: key);

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("Checkout page"),
      ),

      body: ListView(
        shrinkWrap: true,
        primary: false,
        children: [

          Padding(
            padding: const EdgeInsets.all(18.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Shipping Address",style: TextStyle(
                  fontSize: 18
                ),),
                InkWell(
                  onTap: (){
                    Get.to(AddressScreen());
                    print("Add");
                  },
                  child: Text("Add Address",style: TextStyle(
                      fontSize: 18,
                    fontWeight: FontWeight.bold
                  ),),
                ),

              ],
            ),
          )







        ],
      ),


    );
  }
}
