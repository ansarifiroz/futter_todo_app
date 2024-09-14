import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app2/login.dart';
import 'package:flutter_app2/menuPage.dart';
import 'package:flutter_app2/todoController.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:io';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TodoController valueShowController = Get.put(TodoController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  String _fullName = '';
  String _email = '';
  String _image = '';

  @override
  void initState() {
    super.initState();
    valueShowController.loadToDos();
    loadFullName();
   
  }

  loadFullName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String firstName = prefs.getString('fisrt_name') ?? '';
    String lastName = prefs.getString('last_name') ?? '';
    String email = prefs.getString('email') ?? '';
    String image = prefs.getString('image_path') ?? '';
    setState(() {
      _fullName = '$firstName $lastName';
      _email = email;
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        systemOverlayStyle:
            SystemUiOverlayStyle(statusBarColor: Color(0xFFFFFFFF)),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.grey,
        foregroundColor: Colors.black,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
            Container(
              padding: EdgeInsets.only(left: 100),
              alignment: Alignment.center,
              child: Text('My ToDos'),
            )
          ],
        ),
      ),
      drawer: SizedBox(
        width: screenWidth * 0.5,
        child: Drawer(
          child: ListView(
            children: [
              Container(
                color: Colors.grey,
                height: screenHeight * 0.2,
                padding: EdgeInsets.only(top: 20),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 50,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _image != null
                            ? FileImage(File(_image))
                            : AssetImage('assets/images/profile.png')
                                as ImageProvider,
                      ),
                    ),
                    Text(
                      _fullName,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      _email,
                      style: TextStyle(
                        fontSize: 15,
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                title: Text('Update_profile'.tr),
                onTap: () {
                  Get.to(() => MenuPage());
                },
              ),
              ListTile(
                title: Text('Change Theme'.tr),
                onTap: () {
                  Get.changeTheme(
                      Get.isDarkMode ? ThemeData.light() : ThemeData.dark());
                },
              ),
              ListTile(
                title: Text('Logout'.tr),
                trailing: Icon(
                  Icons.logout,
                ),
                onTap: () async {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  prefs.remove('isLogIn');
                
                  Get.offAll(LogInPage());
                },
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.grey,
        onPressed: () {
          valueShowController.addFuntion(context);
        },
        child: const Icon(Icons.add),
      ),
      backgroundColor: const Color(0xFFFFFFFF),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (valueShowController.note.isEmpty) {
                return Center(
                  child: Text(
                    'Add_todo'.tr,
                    style: TextStyle(fontSize: 20, color: Colors.grey.shade600),
                  ),
                );
              } else {
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: valueShowController.note.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(valueShowController.note[index]),
                          Row(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit, size: 30),
                                onPressed: () {
                                  valueShowController.updateFunction(
                                      context, index);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete, size: 30),
                                onPressed: () {
                                  valueShowController.deleteFunction(index);
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }
            }),
          ),
        ],
      ),
    );
  }
}
