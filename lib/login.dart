// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app2/createAccount.dart';
import 'package:flutter_app2/home.dart';
import 'package:flutter_app2/todoController.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/dialog/dialog_route.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  final _formKey = GlobalKey<FormState>();
  bool PasswordVisibility = true;
  TextEditingController UserId = TextEditingController();
  TextEditingController Pass = TextEditingController();
  var AuthMsg = '';
  final valueShowController = Get.put(TodoController());
  var flagset = 'assets/images/usflag.png'.obs;

  @override
  Widget build(BuildContext context) {
    var Screenheight = MediaQuery.of(context).size.height;
    var Screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: Color(0xFFFFFFFF),
            child: Column(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Container(
                        child: Text(
                          'Login Account'.tr,
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Icon(
                        Icons.person_outline_rounded,
                        size: 35,
                      )
                    ],
                  ),
                  // subtitle: Text(
                  //   'Welcomeback Your Name!'.tr,
                  //   style: TextStyle(
                  //       fontSize: 15,
                  //       color: Colors.black,
                  //       fontWeight: FontWeight.w400),
                  // ),
                  trailing: Container(
                    width: 70,
                    child: Row(
                      children: [
                        InkWell(
                          child: Container(
                            height: Screenheight * 0.03,
                            width: Screenwidth * 0.06,
                            child: Image.asset(
                              flagset.value,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    title: Text('Select Language'.tr),
                                    content: Container(
                                      height: Screenheight * 0.15,
                                      child: Column(
                                        children: [
                                          ListTile(
                                            title: Text('Englis'.tr),
                                            onTap: () {
                                              var english = Locale('en', 'US');
                                              Get.updateLocale(english);
                                              flagset.value =
                                                  'assets/images/usflag.png';
                                              Navigator.of(context).pop();
                                            },
                                          ),
                                          ListTile(
                                            title: Text('Hindi'.tr),
                                            onTap: () {
                                              var hindi = Locale('hi', 'Hi');
                                              Get.updateLocale(hindi);
                                              flagset.value =
                                                  'assets/images/india.png';
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                          child: Icon(
                            Icons.arrow_drop_down,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 70,
                ),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 70),
                      height: 100,
                      width: double.infinity,
                      child: Row(
                        children: [
                          Text(
                            'My'.tr,
                            style: TextStyle(
                                fontSize: 60,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "ToDo's".tr,
                            style: TextStyle(
                                fontSize: 60,
                                color: Color(0xFFFFC600),
                                fontWeight: FontWeight.w800),
                          )
                        ],
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        height: Screenheight * 0.08,
                        width: Screenwidth * 0.96,
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        child: TextFormField(
                          controller: UserId,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: 'Enter User Id'.tr,
                            hintStyle: TextStyle(color: Color(0xFF6D6a6a)),
                          ),
                          validator: (Value) {
                            if (Value!.isEmpty) {
                              return 'notice'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 25),
                        height: Screenheight * 0.08,
                        width: Screenwidth * 0.96,
                        child: TextFormField(
                          controller: Pass,
                          obscureText: PasswordVisibility,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    PasswordVisibility = !PasswordVisibility;
                                  });
                                },
                                icon: Icon(PasswordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            border: OutlineInputBorder(),
                            hintText: 'Enter Password'.tr,
                            hintStyle: TextStyle(color: Color(0xFF6D6a6a)),
                          ),
                          validator: (Value) {
                            if (Value!.isEmpty) {
                              return 'notice'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          right: 35,
                        ),
                        alignment: Alignment.bottomRight,
                        child: Text(
                          'Forget Password?'.tr,
                          style: TextStyle(color: Colors.black, fontSize: 15),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: Screenheight * 0.07,
                        width: Screenwidth * 0.85,
                        decoration: BoxDecoration(
                            color: Color(0xFFFFC600),
                            borderRadius: BorderRadius.circular(10)),
                        child: ElevatedButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              var storedEmail = prefs.getString('user_id');
                              var storedPas = prefs.getString('password');
                              if (UserId.text == storedEmail &&
                                  Pass.text == storedPas) {
                                await prefs.setBool('isLogIn', true);
                                setState(() {
                                  AuthMsg = 'Login Successfull'.tr;
                                });
                                Get.offAll(HomeScreen());
                              } else {
                                setState(() {
                                  AuthMsg = 'Incorrect user or password'.tr;
                                });
                              }
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  AuthMsg,
                                  style: TextStyle(fontSize: 18),
                                ),
                                backgroundColor: AuthMsg.contains('Failed')
                                    ? Colors.red
                                    : Colors.green,
                                duration: Duration(seconds: 1),
                              ));
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Color(0xFFFFC600))),
                          child: Text('Login'.tr,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(child: Divider()),
                          Text('Or sign up with'.tr),
                          Container(
                              padding: EdgeInsets.only(right: 30),
                              child: Divider())
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 70, left: 70),
                        height: 100,
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 60,
                              width: 80,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5,
                                        spreadRadius: 0,
                                        offset: Offset(1, 1))
                                  ],
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/google.png',
                                      ),
                                      scale: .8),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              height: 60,
                              width: 80,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 5,
                                        spreadRadius: 0,
                                        offset: Offset(1, 1))
                                  ],
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/Group.png',
                                      ),
                                      scale: .8),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                            Container(
                              height: 60,
                              width: 80,
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey.shade300,
                                        blurRadius: 4,
                                        spreadRadius: 0,
                                        offset: Offset(1, 1))
                                  ],
                                  color: Colors.white,
                                  image: DecorationImage(
                                      image: AssetImage(
                                        'assets/images/Vector.png',
                                      ),
                                      scale: .8),
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 130),
                              child: Text(
                                'Not registerd?'.tr,
                                style: TextStyle(
                                    color: Color(0xFF636363), fontSize: 15),
                              ),
                            ),
                            SizedBox(
                              width: Screenwidth * 0.01,
                            ),
                            Container(
                              // padding: EdgeInsets.only(left: 70),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CreateAccount()));
                                },
                                child: Text(
                                  'Create Account'.tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            )
                          ],
                        ),
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
  }
}
