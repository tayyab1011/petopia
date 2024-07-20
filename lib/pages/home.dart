import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:petopia/pages/details.dart';
import 'package:petopia/service/database.dart';
import 'package:petopia/widget/widget_support.dart';
import 'order.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore db= FirebaseFirestore.instance;
  late Stream<QuerySnapshot<Map<String,dynamic>>> dataStream;
  
  late String userId;

  int selectedCategory=0;
  bool catfood=false;
  bool dogfood=false;


  void _initializeUserId() {
    // Assuming user is logged in and FirebaseAuth instance is available
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      setState(() {
        userId = user.uid;
      });
    }
  }

  @override
  void initState() {
    dataStream=db.collection('products').snapshots();
    super.initState();
    _initializeUserId();

  }

  Widget allitems() {
    return StreamBuilder(
        stream: dataStream,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final product = snapshot.data!.docs[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => Details(product: product.data())));
                      },
                      child: Container(
                        child: Material(
                          elevation: 6.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Padding(
                            padding: EdgeInsets.all(6),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                  product['imageUrl'],
                                  height: 100,
                                  width: 100,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        product['title'],
                                        style:
                                            AppWidget.semiBoldTextFieldStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        product['category'],
                                        style: AppWidget.lightTextFieldStyle(),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        '\$${product['price']}',
                                        style:
                                            AppWidget.semiBoldTextFieldStyle(),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
              : Center(
            child: Text("No items to show"),
          );;
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(top: 30, left: 20, right: 10),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Petopia",
                        style: TextStyle(letterSpacing: 2, fontSize: 22,
                            color: Color(0xffff5722),
                            fontWeight: FontWeight.bold,
                            fontFamily: "Poppins"),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: ((context) =>OrderScreen(userId: userId))));

                        },
                        child: Container(
                          padding: EdgeInsets.all(3),
                          decoration: BoxDecoration(
                              color: Color(0xffff5722),
                              borderRadius: BorderRadius.circular(8)),
                          child: Icon(
                            Icons.shopping_cart_outlined,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Your One-Stop Pet Food",
                    style: AppWidget.headlineTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Discover and Get Great Food",
                    style: AppWidget.lightTextFieldStyle(),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                            catfood=true;
                            dogfood=false;
                            dogfood==false;
                            if(dogfood==false){
                              dataStream=db.collection('products').where('category',isEqualTo: "Cat").snapshots();
                            }

                          });
                        },
                        child: Material(
                          elevation: 6.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: catfood ? Color(0xffff5722) : null,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Image.asset(
                                "images/food.png",
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          setState(() {
                           catfood==false;
                           dogfood=true;
                           catfood=false;
                            if(catfood==false){
                              dataStream=db.collection('products').where('category',isEqualTo: 'Dog').snapshots();
                            }
                          });
                        },
                        child: Material(
                          elevation: 6.0,
                          borderRadius: BorderRadius.circular(10),
                          child: Container(
                              decoration: BoxDecoration(
                                  color: dogfood ? Color(0xffff5722) : null,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: EdgeInsets.all(8),
                              child: Image.asset(
                                "images/dog.png",
                                height: 70,
                                width: 70,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(child: allitems()),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
