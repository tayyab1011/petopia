// ignore_for_file: prefer_const_constructors, sort_child_properties_last, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:petopia/service/cart_provider.dart';
import 'package:petopia/pages/order_confirmation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'cart_page.dart';

class CheckOutPage extends StatefulWidget {
  final total;
  const CheckOutPage({super.key, required this.total});

  @override
  State<CheckOutPage> createState() => _CheckOutPageState();
}

class _CheckOutPageState extends State<CheckOutPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;


  final cities = ['Multan', 'Lahore', 'Karachi', 'Islamabad', 'Peshawar'];
  String? selectedCity;
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey();

  FirebaseFirestore db=FirebaseFirestore.instance;

  void addOrderWithCustomId(String customId, Map<String, dynamic> orderData) async {
    await FirebaseFirestore.instance.collection('orders').doc(customId).set(orderData);
  }

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Checkout'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: nameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      hintText: 'Enter your name',
                      icon: Icon(Icons.person),
                      alignLabelWithHint: true,
                      labelText: 'Enter Name',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Name";
                    } else {
                      return null;
                    }
                  },
                ),
                SizedBox(
                  height: 12,
                ),
                TextFormField(
                  controller: mobileController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter Mobile Number";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter your Mobile Number',
                      icon: Icon(Icons.phone_android),
                      alignLabelWithHint: true,
                      labelText: 'Enter Number',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 16,
                ),
                Container(
                    margin: EdgeInsets.only(left: 40),
                    child: Text(
                      "Location",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.black87),
                    )),
                Row(
                  children: [
                    Icon(Icons.location_pin),
                    SizedBox(
                      width: 16,
                    ),
                    Expanded(
                      child: DropdownButtonFormField(
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please Select City";
                            } else {
                              return null;
                            }
                          },
                          isExpanded: true,
                          hint: Text('Select City'),
                          items: cities
                              .map((e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ))
                              .toList(),
                          value: selectedCity,
                          onChanged: ((value) {
                            setState(() {
                              selectedCity = value;
                            });
                          })),
                    ),
                  ],
                ),
                SizedBox(
                  height: 24,
                ),
                TextFormField(
                  controller: addressController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your Address";
                    } else {
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'House No./Buildng No , Street No.',
                      icon: Icon(Icons.navigation),
                      alignLabelWithHint: true,
                      labelText: 'Address',
                      labelStyle: TextStyle(fontWeight: FontWeight.bold),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                      floatingLabelStyle:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 40,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Total \$"+widget.total.toString(),style: TextStyle(fontWeight: FontWeight.bold),),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: ()async {
                    if (formKey.currentState!.validate()) {
                      String name = nameController.text.trim();
                      String mobileNumber = mobileController.text.trim();
                      String address = addressController.text.trim();
                      final Timestamp dateTime = Timestamp.now();
                      final User? user = _auth.currentUser;
                      final price = widget.total.toDouble();

                      setState(() {
                        isLoading=true;
                      });

                      db.collection('orders').add({
                        'name':name,
                        'mobile_number':mobileNumber,
                        'address':address,
                        'dateTime':dateTime,
                        'uid': user!.uid,
                        'price':price,
                        'city':selectedCity,
                        'items':context.read<CartProvider>().cartList
                      }).then((value) {
                        setState(() {
                          isLoading=false;
                        });
                        context.read<CartProvider>().clearCart()  ;
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: ((context) => orderConfirmatiomPage(
                                name: name,
                                mobileNumber: mobileNumber,
                                city: selectedCity!,
                                address: address)
                            )
                        ),);
                      } ).onError((error, stackTrace) {
                        isLoading=false;
                        print(error);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Something went wrong!"),));
                      });


                    }
                  },
                  child: Text(
                    'Place Oder',
                  ),
                  style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black87,
                      backgroundColor: Color(0xffff5722),
                      minimumSize: Size(double.infinity, 40)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
