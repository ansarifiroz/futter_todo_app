// ignore_for_file: prefer_const_constructors, sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userIDController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();
  bool PasswordVisibilty = true;
  var name = '';

  File? _image;
  final  _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    load_data();
  }

  load_data() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      firstNameController.text = prefs.getString('fisrt_name') ?? '';
      lastNameController.text = prefs.getString('last_name') ?? '';
      userIDController.text = prefs.getString('user_id') ?? '';
      emailController.text = prefs.getString('email') ?? '';
      phoneNumberController.text = prefs.getString('phone_number') ?? '';
      passwordController.text = prefs.getString('password') ?? '';
      String? imagePath = prefs.getString('image_path');
      if (imagePath != null) {
        _image = File(imagePath);
      }
    });
  }

  _pickImage(ImageSource source) async {
    XFile? image = await _picker.pickImage(source: source);
    if (image != null) {
      setState(() {
        _image = File(image.path);
      });
    }
  }

  _showPickerOption() {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
              child: Wrap(
            children: [
              ListTile(
                  leading: Icon(Icons.photo_library),
                  title: Text('Gallery'),
                  onTap: () {
                    _pickImage(ImageSource.gallery);
                    Navigator.of(context).pop();
                  }),
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take Photo'),
                onTap: () {
                  _pickImage(ImageSource.camera);
                  Navigator.of(context).pop();
                },
              )
            ],
          ));
        });
  }

  _saveUpdatedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('first_name', firstNameController.text);
    await prefs.setString('last_name', lastNameController.text);
    await prefs.setString('user_id', userIDController.text);
    await prefs.setString('email', emailController.text);
    await prefs.setString('phone_number', phoneNumberController.text);
    await prefs.setString('password', passwordController.text);
    if (_image != null) {
      await prefs.setString('image_path', _image!.path);
    }

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        'Profile updated successfully'.tr,
        style: const TextStyle(fontSize: 18),
      ),
      backgroundColor: Colors.green,
      duration: const Duration(seconds: 1),
    ));
  }

  @override
  Widget build(BuildContext context) {
    var Screenheight = MediaQuery.of(context).size.height;
    var Screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundColor: Colors.grey.shade400,
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: _image != null
                        ? FileImage(_image!)
                        : AssetImage('assets/images/profile.png')
                            as ImageProvider,
                  ),
                ),
                Positioned(
                  bottom: 5,
                  right: 10,
                  child: GestureDetector(
                    onTap: _showPickerOption,
                    child: Container(
                      child: Padding(
                        padding: EdgeInsets.all(2.0),
                        child: Icon(
                          Icons.add_a_photo,
                          color: Colors.black,
                        ),
                      ),
                      decoration: BoxDecoration(
                          border: Border.all(width: 3, color: Colors.white),
                          borderRadius: BorderRadius.all(Radius.circular(50)),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                                offset: Offset(2, 4),
                                color: Colors.black.withOpacity(0.3),
                                blurRadius: 3)
                          ]),
                    ),
                  ),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.only(top: 50),
              child: Column(
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 25),
                        width: Screenwidth * 0.45,
                        child: TextFormField(
                          controller: firstNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'First_Name'.tr,
                              hintStyle: TextStyle(color: Color(0xFF6D6a6a))),
                          validator: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return 'notice'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        width: Screenwidth * 0.02,
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 25),
                        width: Screenwidth * 0.53,
                        child: TextFormField(
                          controller: lastNameController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              hintText: 'Last_name'.tr,
                              hintStyle: TextStyle(color: Color(0xFF6D6a6a))),
                          validator: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return 'notice'.tr;
                            }
                            return null;
                          },
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: Screenheight * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    child: TextFormField(
                      controller: userIDController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'User'.tr,
                        hintStyle: TextStyle(color: Color(0xFF6D6a6a)),
                      ),
                      validator: (Value) {
                        if (Value == null || Value.isEmpty) {
                          return 'notice'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: Screenheight * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    child: TextFormField(
                      controller: emailController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter email id'.tr,
                        hintStyle: TextStyle(color: Color(0xFF6D6a6a)),
                      ),
                      validator: (Value) {
                        if (Value == null || Value.isEmpty) {
                          return 'notice'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    child: TextFormField(
                      controller: phoneNumberController,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Phone_number'.tr,
                        hintStyle: TextStyle(color: Color(0xFF6D6a6a)),
                      ),
                      validator: (Value) {
                        if (Value == null || Value.isEmpty) {
                          return 'notice'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 25),
                    width: double.infinity,
                    child: TextFormField(
                      obscureText: PasswordVisibilty,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                PasswordVisibilty = !PasswordVisibilty;
                              });
                            },
                            icon: Icon(PasswordVisibilty
                                ? Icons.visibility
                                : Icons.visibility_off)),
                        border: OutlineInputBorder(),
                        hintText: 'Enter Password'.tr,
                        hintStyle: TextStyle(color: Color(0xFF6D6a6a)),
                      ),
                      validator: (Value) {
                        if (Value == null || Value.isEmpty) {
                          return 'notice'.tr;
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        _saveUpdatedData();
                      },
                      style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        backgroundColor:
                            Color(0xFFFFC600), // Background color of the button

                        elevation: 5, // Elevation of the button
                      ),
                      child: Text(
                        'Update_Profile'.tr,
                        style: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
