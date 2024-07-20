import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:petopia/admin/admin_login.dart';
import 'package:petopia/pages/bottomnav.dart';
import 'package:petopia/pages/forgotpassword.dart';
import 'package:petopia/pages/signup.dart';
import 'package:petopia/widget/widget_support.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  String email = "", password = "";

  final _formkey = GlobalKey<FormState>();

  TextEditingController useremailcontroller = new TextEditingController();
  TextEditingController userpasswordcontroller = new TextEditingController();

  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => BottomNav()));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "No User Found for that Email",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        )));
      } else if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
          "Wrong Password Provided by User",
          style: TextStyle(fontSize: 18.0, color: Colors.black),
        )));
      }
      else if (e.code == 'invalid-credential') {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              "Invalid Username/Password",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )));
      }

    }
  }
  bool isPasswordHidden=true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Expanded(
            child: Stack(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                        Color(0xFFff5c30),
                        Color(0xFFe74b1a),
                      ])),
                ),
                Container(
                  margin: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 2.5),
                  height: MediaQuery.of(context).size.height / 2,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40))),
                  child: Text(""),
                ),
                Container(
                  margin: EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                  child: Column(
                    children: [
                      Center(
                          child: Image.asset(
                        "images/app_logo.png",
                        width: 140,
                        height: 130,
                        fit: BoxFit.cover,

                      )),
                      SizedBox(
                        height: 50.0,
                      ),
                      Material(
                        elevation: 5.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height / 1.6,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: 30.0,
                                ),
                                Text(
                                  "Login",
                                  style: AppWidget.headlineTextFieldStyle(),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  controller: useremailcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Email';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      hintText: 'Email',
                                      hintStyle:
                                          AppWidget.semiBoldTextFieldStyle(),
                                      prefixIcon: Icon(Icons.email_outlined)),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                TextFormField(
                                  controller: userpasswordcontroller,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please Enter Password';
                                    }
                                    return null;
                                  },
                                  obscureText: isPasswordHidden,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle:
                                        AppWidget.semiBoldTextFieldStyle(),
                                    prefixIcon: Icon(Icons.lock_outline),
                                    suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            isPasswordHidden =
                                                !isPasswordHidden;
                                          });
                                        },
                                        icon: Icon(isPasswordHidden
                                            ? Icons.visibility_off
                                            : Icons.visibility)),
                                  ),
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
                                  },
                                  child: Container(
                                      alignment: Alignment.topRight,
                                      child: Text(
                                        "Forgot Password?",
                                        style:
                                            AppWidget.semiBoldTextFieldStyle(),
                                      )),
                                ),
                                SizedBox(
                                  height: 50.0,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    if (_formkey.currentState!.validate()) {
                                      setState(() {
                                        email = useremailcontroller.text;
                                        password = userpasswordcontroller.text;
                                      });
                                    }
                                    userLogin();
                                  },
                                  child: Material(
                                    elevation: 5.0,
                                    borderRadius: BorderRadius.circular(20),
                                    child: Container(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 8.0),
                                      width: 200,
                                      decoration: BoxDecoration(
                                          color: Color(0Xffff5722),
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Center(
                                          child: Text(
                                        "LOGIN",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18.0,
                                            fontFamily: 'Poppins1',
                                            fontWeight: FontWeight.bold),
                                      )),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUp()));
                          },
                          child: Container(
                            margin: EdgeInsets.only(bottom: 25),
                            child: Text(
                              "Don't have an account? Sign up",
                              style: AppWidget.semiBoldTextFieldStyle(),
                            ),
                          )),
                      SizedBox(
                        height: 10.0,
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.of(context).push(MaterialPageRoute(builder: ((context)=> AdminLogin())));
                        },
                        child: Container(
                          padding:
                          EdgeInsets.symmetric(vertical: 8.0),
                          width: 200,
                          decoration: BoxDecoration(
                              color: Color(0Xffff5722),
                              borderRadius:
                              BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                                "Login As Admin",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18.0,
                                    fontFamily: 'Poppins1',
                                    fontWeight: FontWeight.bold),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
