import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/database/database_helper.dart';
import 'package:food_app/model/cart_model.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final CartProvider cartdata = Get.put(CartProvider());
  final ProductController _controller = Get.put(ProductController());
  final CartProvider cart = Get.put(CartProvider());
  DBHelper _dbHelper = DBHelper();
  List<Cart> ?dataval;
  @override
  void initState() {

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    cartdata.getData().then((value) {
      dataval = value;
    });
    return Scaffold(
      appBar: AppBar(
        title: Text("Cart Screen"),
        backgroundColor: BG_COLOR,
      ),



      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: cartdata.getData(),
              builder: (_, snapshot) {
                return Container(
                  child: snapshot.data!.isNotEmpty ?  ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshot.data!.length,
                    itemBuilder: (_, index) {
                      var data = snapshot.data![index];
                      return Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(left: 16, right: 16, top: 16),
                            decoration: BoxDecoration(
                                color: BG_COLOR,
                                borderRadius: BorderRadius.all(Radius.circular(16))),
                            child: Row(
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(
                                      right: 8, left: 8, top: 8, bottom: 8),
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(14)),
                                    color: Colors.blue.shade200,
                                    image: DecorationImage(
                                      image: NetworkImage(data.image.toString()),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.max,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: EdgeInsets.only(right: 8, top: 4),
                                          child: Text(
                                            "${data.productName}",
                                            maxLines: 2,
                                            softWrap: true,
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 6,
                                        ),
                                        Text(
                                          "${data.unit}",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                          ),
                                        ),
                                        Container(
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: <Widget>[
                                              Text(
                                                "${data.productPrice}",
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Icon(
                                                      Icons.remove,
                                                      size: 24,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                    ),
                                                    Container(
                                                      color: Colors.grey.shade200,
                                                      padding: const EdgeInsets.only(
                                                          bottom: 2,
                                                          right: 12,
                                                          left: 12),
                                                      child: Text(
                                                        "${data.quantity}",
                                                        style: TextStyle(
                                                            color: Color.fromARGB(
                                                                255, 55, 55, 55)),
                                                      ),
                                                    ),
                                                    Icon(
                                                      Icons.add,
                                                      size: 24,
                                                      color: Color.fromARGB(
                                                          255, 255, 255, 255),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  flex: 100,
                                )
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: (){
                             _dbHelper.delete(data.productId!);

                             cart.removerCounter();
                             cart.removeTotalPrice(data.productPrice!.toDouble());
                             setState(() {

                             });
                            },
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                width: 24,
                                height: 24,
                                alignment: Alignment.center,
                                margin: EdgeInsets.only(right: 10, top: 8),
                                child: Icon(
                                  Icons.delete,
                                  color: Color.fromARGB(255, 247, 25, 25),
                                  size: 20,
                                ),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(4)),
                                    color: Color.fromARGB(255, 246, 244, 244)),
                              ),
                            ),
                          ),






                        ],
                      );
                    },
                  )
                  :Center(
                    child: Text("cart is empty"),
                  )
                  ,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 38.0),
            child: InkWell(
              onTap: (){

              },
              child: FutureBuilder<double>(
                future: cart.getTotalPrice(),
                builder: (_,snapshot){
                  if(snapshot.hasData){
                    return  Container(
                      // height: 50,
                      // width: double.infinity,

                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(left: 30),
                                child: Text(
                                  "Total",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 30),
                                child: Text(
                                  "${snapshot.data.toString()}",
                                  style: TextStyle(
                                    fontSize: 22,fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 8),
                          dataval!.isNotEmpty ?    ElevatedButton(
                            onPressed: () {},
                            child: Text(
                              "Checkout",
                              style: TextStyle(),
                            ),
                          ) : Container(),
                          SizedBox(height: 8),
                        ],
                      ),
                      margin: EdgeInsets.only(top: 16),
                    );
                  }else{
                    return Container();
                  }
                },
              ),
            ),
          ),
        ],
      ),

    );
  }


}
