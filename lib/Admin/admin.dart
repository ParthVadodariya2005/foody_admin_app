import 'package:flutter/material.dart';
import 'package:foody_admin_app/Admin/admin_home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:foody_admin_app/Admin/admin_signup.dart';
import 'package:foody_admin_app/widget/widget_support.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  State<AdminLogin> createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  TextEditingController useremailcontroller = TextEditingController();
  TextEditingController userpasswordcontroller = TextEditingController();
  String email = "";
  String password = "";

 userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => HomeAdmin()));
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
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFededeb),
      body: Container(
        child: Stack(
          children: [
            Container(
              margin:
                  EdgeInsets.only(top: MediaQuery.of(context).size.height / 2),
              padding: EdgeInsets.only(top: 45.0, left: 20.0, right: 20.0),
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color.fromARGB(255, 53, 51, 51), Colors.black],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                  borderRadius: BorderRadius.vertical(
                      top: Radius.elliptical(
                          MediaQuery.of(context).size.width, 110.0))),
            ),
            Container(
              margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
              child: Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      Text(
                        "Let's start with\nAdmin!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Material(
                        elevation: 3.0,
                        borderRadius: BorderRadius.circular(20),
                        child: Container(
                          height: MediaQuery.of(context).size.height / 2.2,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 20.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20.0, top: 5.0, bottom: 5.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(255, 160, 160, 147)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: TextFormField(
                                    controller: useremailcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Email';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Email",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 20.0, top: 5.0, bottom: 5.0),
                                margin: EdgeInsets.symmetric(horizontal: 20.0),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Color.fromARGB(255, 160, 160, 147)),
                                    borderRadius: BorderRadius.circular(10)),
                                child: Center(
                                  child: TextFormField(
                                    controller: userpasswordcontroller,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Password';
                                      }
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Password",
                                        hintStyle: TextStyle(
                                            color: Color.fromARGB(
                                                255, 160, 160, 147))),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    email = useremailcontroller.text;
                                    password = userpasswordcontroller.text;
                                  });
                                  if (_formkey.currentState!.validate()) {
                                    userLogin();
                                  }
                                },
                                child: Container(
                                  padding: EdgeInsets.symmetric(vertical: 12.0),
                                  margin: EdgeInsets.symmetric(horizontal: 20.0),
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      color: Colors.black,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Center(
                                    child: Text(
                                      "Log In",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 30),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => AdminSignUp()));
                                },
                                child: Text(
                                  "Don't have an account? Sign up",
                                  style: AppWidget.semiBoldTextFeildStyle(),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  )),
            )
          ],
        ),
      ),
    );
  }
}
