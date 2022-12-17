import 'package:flutter/material.dart';
import 'package:food_app/controller/cart_controller.dart';
import 'package:food_app/controller/product_controller.dart';
import 'package:food_app/database/database_helper.dart';
import 'package:food_app/model/cart_model.dart';
import 'package:food_app/screens/cart_screen.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController _controller = Get.put(ProductController());
  final DBHelper dbHelper = DBHelper();

  List<int> _counter = [];

  increment(int index) {
    setState(() {
      _counter[index]++;
    });
  }

  decrement(int index) {
    setState(() {
      if (_counter[index] > 0) {
        _counter[index]--;
      }
    });
  }

  final CartProvider cart = Get.put(CartProvider());

  @override
  Widget build(BuildContext context) {
    dbHelper.getCartList();
    return Scaffold(
      bottomNavigationBar: InkWell(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (_)=> CartScreen()));

        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            decoration: BoxDecoration(
              color: BG_COLOR
            ),
            height: 50,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Padding(
                  padding: const EdgeInsets.only(left: 18.0),
                  child: Text("Total Price  : ",style: TextStyle(
                    fontSize:20,fontWeight: FontWeight.bold,
                    color: Colors.white
                  ),),
                ),
               FutureBuilder<double>(
                 future: cart.getTotalPrice(),
                 builder: (_,snapshot){
                   if(snapshot.hasData){
                     return  Padding(
                       padding: const EdgeInsets.only(right: 18.0),
                       child: Text("BDT ${snapshot.data.toString()}",style: TextStyle(
                           fontSize:20,fontWeight: FontWeight.bold,
                           color: Colors.white
                       ),),
                     );
                   }else{
                     return Container();
                   }
                 },
               ),

              ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          InkWell(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=> CartScreen()));
            },
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 23.0, top: 16),
                  child: Icon(
                    Icons.shopping_cart,
                    size: 30,
                  ),
                ),
                FutureBuilder(
                  future: cart.getCounter(),
                  builder: (_,snapshot){
                    if(snapshot.hasData){
                      return     Text(
                        "${snapshot.data.toString()}",
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.red,
                            fontWeight: FontWeight.w800),
                      );
                    }
                    return Container();

                  },
                ),

              ],
            ),
          )
        ],
        backgroundColor: BG_COLOR,
        title: Text("Product"),
      ),
      body: Obx(() {
        if (_controller.loader.value) {
          return Center(
            child: CircularProgressIndicator(
              color: Colors.indigo,
            ),
          );
        } else {
          return GridView.builder(
              itemCount: _controller.productlist.value.popular!.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 4,
              ),
              itemBuilder: (_, index) {
                var data = _controller.productlist.value.popular![index];
                _counter.add(0);
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 3,
                    child: InkWell(
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(height: 8),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(13),
                            child: Image.network(
                              // height: MediaQuery.of(context).size.height*0.2,
                              data.image!.thumbnail.toString(),
                              fit: BoxFit.fill,
                              height: 100,
                            ),
                          ),
                          SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 15),
                            child: Text(
                              data.name.toString(),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15, top: 10),
                            child: Text(
                              "BDT ${data.price.toString()}",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 8.0, right: 9),
                                child: InkWell(
                                  onTap: () {
                                    decrement(index);
                                    dbHelper
                                        .insert(Cart(
                                      productId: data.id.toString(),
                                      productName: data.name,
                                      initialPrice: data.price,
                                      productPrice: data.price!,
                                      quantity:
                                      cart.getCartProductQuantity(data.id!) - 1,
                                      image: data.image!.thumbnail,
                                      unit: data.unit,
                                    ))
                                        .then((valuedddd) {

                                      cart.addTotalPrice(
                                          data.price!.toDouble());
                                      cart.addCounter();
                                      setState(() {

                                      });
                                    }).onError((error, stackTrace) {
                                      print("Error=========");
                                      print("Error ${error.toString()}");
                                    });

                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(6),
                                      //  height: 35,
                                      // width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 8.0),
                                        child: Icon(
                                          Icons.minimize,
                                          color: Colors.white,
                                        ),
                                      )),
                                ),
                              ),
                              Text(
                                "${cart.getCartProductQuantity(data!.id!)}",

                                style: TextStyle(
                                    fontSize: 18, color: Colors.black),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 18.0, right: 9),
                                child: InkWell(
                                  onTap: () {
                                    increment(index);
                                    dbHelper
                                        .insert(Cart(
                                      productId: data.id.toString(),
                                      productName: data.name,
                                      initialPrice: data.price,
                                      productPrice: data.price!,
                                      quantity:
                                          cart.getCartProductQuantity(data.id!) + 1,
                                      image: data.image!.thumbnail,
                                      unit: data.unit,
                                    ))
                                        .then((valuedddd) {

                                      cart.addTotalPrice(
                                          data.price!.toDouble());
                                      cart.addCounter();
                                      setState(() {

                                      });
                                    }).onError((error, stackTrace) {
                                      print("Error=========");
                                      print("Error ${error.toString()}");
                                    });

                                    setState(() {

                                    });
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(6),
                                      //  height: 35,
                                      // width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
      }),
    );
  }
}
