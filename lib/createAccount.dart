import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final userIDController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final passwordController = TextEditingController();
  final reEnterPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool passwordVisibility = true;

  @override
  Widget build(BuildContext context) {
    var Screenheight = MediaQuery.of(context).size.height;
    var Screenwidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xFFFFFFFF),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            color: const Color(0xFFFFFFFF),
            child: Column(
              children: [
                ListTile(
                  title: Row(
                    children: [
                      Text(
                        'Create_Account'.tr,
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    'Fill_All_details'.tr,
                    style: const TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                        fontWeight: FontWeight.w400),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 70),
                      height: 100,
                      width: double.infinity,
                      child: const Row(
                        children: [
                          Text(
                            'My',
                            style: TextStyle(
                                fontSize: 60,
                                color: Colors.black,
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "ToDo's",
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
                const SizedBox(
                  height: 30,
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.only(left: 25),
                            width: Screenwidth * 0.45,
                            child: TextFormField(
                              controller: firstNameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'First_Name'.tr,
                                  labelStyle: const TextStyle(
                                      color: Color(0xFF6D6a6a))),
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
                            padding: const EdgeInsets.only(right: 25),
                            width: Screenwidth * 0.53,
                            child: TextFormField(
                              controller: lastNameController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                  border: const OutlineInputBorder(),
                                  labelText: 'Last_name'.tr,
                                  labelStyle: const TextStyle(
                                      color: Color(0xFF6D6a6a))),
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
                        height: Screenheight * 0.01,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        width: double.infinity,
                        child: TextFormField(
                          controller: userIDController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'User'.tr,
                            labelStyle:
                                const TextStyle(color: Color(0xFF6D6a6a)),
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
                        height: Screenheight * 0.01,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        width: double.infinity,
                        child: TextFormField(
                          controller: emailController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Enter email id'.tr,
                            labelStyle:
                                const TextStyle(color: Color(0xFF6D6a6a)),
                          ),
                          validator: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return 'notice'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        width: double.infinity,
                        child: TextFormField(
                          controller: phoneNumberController,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Phone_number'.tr,
                            labelStyle:
                                const TextStyle(color: Color(0xFF6D6a6a)),
                          ),
                          validator: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return 'notice'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        width: double.infinity,
                        child: TextFormField(
                          obscureText: passwordVisibility,
                          controller: passwordController,
                          decoration: InputDecoration(
                            suffixIcon: IconButton(
                                onPressed: () {
                                  setState(() {
                                    passwordVisibility = !passwordVisibility;
                                  });
                                },
                                icon: Icon(passwordVisibility
                                    ? Icons.visibility
                                    : Icons.visibility_off)),
                            border: const OutlineInputBorder(),
                            hintText: 'Enter Password'.tr,
                            hintStyle:
                                const TextStyle(color: Color(0xFF6D6a6a)),
                          ),
                          validator: (Value) {
                            if (Value == null || Value.isEmpty) {
                              return 'notice'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        width: double.infinity,
                        child: TextFormField(
                          controller: reEnterPasswordController,
                          decoration: InputDecoration(
                            border: const OutlineInputBorder(),
                            labelText: 'Re_enter Password'.tr,
                            labelStyle:
                                const TextStyle(color: Color(0xFF6D6a6a)),
                          ),
                          validator: (Value) {
                            if (Value != passwordController.text) {
                              return 'Password_notMatch'.tr;
                            }
                            return null;
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: Screenheight * 0.07,
                        width: Screenwidth * 0.8,
                        decoration: BoxDecoration(
                            color: const Color(0xFFFFC600),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextButton(
                          onPressed: () async {
                            if (_formKey.currentState!.validate()) {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setString(
                                  'fisrt_name', firstNameController.text);
                              prefs.setString(
                                  'last_name', lastNameController.text);
                              prefs.setString('user_id', userIDController.text);
                              prefs.setString('email', emailController.text);
                              prefs.setString(
                                  'phone_number', phoneNumberController.text);
                              prefs.setString(
                                  'password', passwordController.text);

                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  'Successfully'.tr,
                                  style: const TextStyle(fontSize: 18),
                                ),
                                backgroundColor: Colors.green,
                                duration: const Duration(seconds: 1),
                              ));
                              Navigator.pop(context);
                            }
                          },
                          style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(
                                  const Color(0xFFFFC600))),
                          child: Text('Sign_up'.tr,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.black)),
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(left: 100),
                              child: Text(
                                'already_account'.tr,
                                style: const TextStyle(
                                    color: Color(0xFF636363), fontSize: 15),
                              ),
                            ),
                            Container(
                              child: InkWell(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: Text(
                                  'Login'.tr,
                                  style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
