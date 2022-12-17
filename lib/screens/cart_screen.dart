import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {


  final CartProvider cartdata = Get.put(CartProvider());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Screen"),
        backgroundColor: BG_COLOR,
      ),
      body: FutureBuilder(
        future: cartdata.getData(),
        builder: (_,snapshot){
          return Container(
            child: ListView.builder(
              shrinkWrap: true,
              primary: false,
              itemCount: snapshot.data!.length,
              itemBuilder: (_,index){
                var data = snapshot.data![index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text("${data.productName}"),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
