import 'dart:convert';

import 'package:clothes_app/api_connection/api_connection.dart';
import 'package:clothes_app/users/authentication/login_screen.dart';
import 'package:clothes_app/users/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isObsecure = true.obs;

  registerAndSaveUserRecords() async {
    User userModal = User(
      1,
      nameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    try {
      var res = await http.post(
        Uri.parse(API.signUp),
        body: userModal.toJson(),
      );

      if (res.statusCode == 200) {
        var resBodyOfSignUp = jsonDecode(res.body);

        if (resBodyOfSignUp['success'] == true) {
          Fluttertoast.showToast(msg: "Congratulations, SignUp Successful");
        } else {
          Fluttertoast.showToast(msg: "Error, SignUp Unsuccessful");
        }
      } else {
        print("HTTP request failed with status: ${res.statusCode}");
        Fluttertoast.showToast(msg: "Error, SignUp Unsuccessful");
      }
    } catch (e) {
      print("Exception during HTTP request: $e");
      Fluttertoast.showToast(msg: "Error, SignUp Unsuccessful");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          return ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // signup screen header
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: 285,
                    child: Image.asset(
                      "images/register.jpg",
                    ),
                  ),
                  // Login Screen goes here
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.white24,
                        borderRadius: BorderRadius.all(
                          Radius.circular(60),
                        ),
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 8,
                            color: Colors.black26,
                            offset: Offset(0, -3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // email - password - login-btn
                          Form(
                            key: formKey,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(30, 30, 30, 8.0),
                              child: Column(
                                children: [
                                  // name
                                  TextFormField(
                                    controller: nameController,
                                    validator: (val) =>
                                    val == "" ? "Please Write Name" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.person,
                                        color: Colors.black,
                                      ),
                                      hintText: "name...",
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ), // Move contentPadding here
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 18,),
                                  //email
                                  TextFormField(
                                    controller: emailController,
                                    validator: (val) =>
                                    val == "" ? "Please Write Email" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.email,
                                        color: Colors.black,
                                      ),
                                      hintText: "email..",
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  ),

                                  SizedBox(height: 18,),
                                  // password

                                  Obx(() => TextFormField(
                                    controller: passwordController,
                                    obscureText: isObsecure.value,
                                    validator: (val) =>
                                    val == "" ? "Please Write Password" : null,
                                    decoration: InputDecoration(
                                      prefixIcon: const Icon(
                                        Icons.vpn_key_sharp,
                                        color: Colors.black,
                                      ),
                                      suffixIcon: Obx(() => GestureDetector(
                                        onTap: () {
                                          isObsecure.value = !isObsecure.value;
                                        },
                                        child: Icon(
                                          isObsecure.value
                                              ? Icons.visibility_off
                                              : Icons.visibility,
                                          color: Colors.black,
                                        ),
                                      ),
                                      ),
                                      hintText: "password",
                                      contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 14,
                                        vertical: 6,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                        borderSide: const BorderSide(
                                          color: Colors.white60,
                                        ),
                                      ),
                                      fillColor: Colors.white,
                                      filled: true,
                                    ),
                                  )),

                                  SizedBox(height: 18,),

                                  //button
                                  Material(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(30),
                                    child: InkWell(
                                      onTap: () {
                                        if (formKey.currentState!.validate()) {
                                          registerAndSaveUserRecords();
                                        }
                                      },
                                      borderRadius: BorderRadius.circular(30),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          vertical: 10,
                                          horizontal: 20,
                                        ),
                                        child: Text(
                                          "Signup",
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),
                          // Already have account Button
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Already Have An Account?"),
                              TextButton(
                                  onPressed: () {
                                    Get.to(LoginScreen());
                                  },
                                  child: const Text(
                                    "Login Here",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 16,
                                    ),
                                  ))
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
