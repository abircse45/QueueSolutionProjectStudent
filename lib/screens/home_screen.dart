import 'package:flutter/material.dart';
import 'package:food_app/controller/product_controller.dart';
import 'package:food_app/utils/colors.dart';
import 'package:get/get.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ProductController _controller = Get.put(ProductController());

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        actions: [
          Stack(
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 18.0,top: 10),
                child: Icon(
                  Icons.shopping_cart
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0),
                child: Text("0",style: TextStyle(
                  fontSize: 15,color: Colors.red,
                  fontWeight: FontWeight.bold
                ),),
              )
            ],
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
                                padding: const EdgeInsets.only(left: 8.0,right: 9),
                                child: InkWell(

                                  onTap: (){
                                    decrement(index);
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(6),
                                  //  height: 35,
                                   // width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: Colors.indigo,
                                      borderRadius: BorderRadius.circular(10.0),
                                    ),
                                    child: Icon(
                                      Icons.minimize,
                                      color: Colors.white,
                                    )
                                  ),
                                ),
                              ),
                              Text("${_counter[index]}",style: TextStyle(
                                fontSize: 18,color: Colors.black
                              ),),
                              Padding(
                                padding: const EdgeInsets.only(left: 18.0,right: 9),
                                child: InkWell(

                                  onTap: (){
                                    increment(index);
                                  },
                                  child: Container(
                                      padding: EdgeInsets.all(6),
                                      //  height: 35,
                                      // width: double.infinity,
                                      decoration: BoxDecoration(
                                        color: Colors.indigo,
                                        borderRadius: BorderRadius.circular(10.0),
                                      ),
                                      child: Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      )
                                  ),
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
