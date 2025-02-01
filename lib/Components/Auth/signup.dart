// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_setup/Components/Auth/signin.dart';
import 'package:flutter/material.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool _isPasswordHidden = true;
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  var uid;
  // var profileImage;
  var profileImage ;
  // var profileImage = " ";
  Future<void> RegsisterUser() async {
    try {
      final userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: email.text, password: password.text);
      final user = userCredential.user;

      setState(() {
        uid = user?.uid;
      });
      // email.text = "";
      // password.text = "";
      // imageStoreStorage();
    } catch (e) {
      print(e.toString());
    }
  }

  pickProfileImage() {}
  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("SIGNUP FORM"),
        ),
        body: Container(
          width: screenWidth,
          height: screenHeight,
          child: SingleChildScrollView(
            child: Form(
              key: _form,
              child: Column(
                children: [
                  // Top banner container
                  // Container(
                  //   height: screenHeight * 0.23,
                  //   width: screenWidth,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.only(
                  //       bottomRight: Radius.circular(20),
                  //       bottomLeft: Radius.circular(20),
                  //     ),
                  //     image: DecorationImage(
                  //       image: NetworkImage(
                  //         "https://img.freepik.com/free-vector/turquoise-circles-background_1128-53.jpg?ga=GA1.1.881659082.1730823737&semt=ais_hybrid",
                  //       ),
                  //       fit: BoxFit.cover,
                  //     ),
                  //   ),
                  // ),
                  SizedBox(
                    height: 15,
                  ),
                  CircleAvatar(
                    radius: 65,
                    backgroundImage:
                        (profileImage == null || profileImage.isEmpty)
                            ? NetworkImage(
                                'https://img.freepik.com/free-photo/entrepreneur-portrait_1098-299.jpg?ga=GA1.1.881659082.1730823737&semt=ais_hybrid',
                              )
                            : FileImage(File(profileImage)) as ImageProvider,
                  ),

                  // Signup Text
                  Padding(
                    padding: EdgeInsets.all(screenWidth * 0.04),
                    child: Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Sign Up",
                              style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              "Fill the form below to create your account",
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Name Input Field
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.01,
                    ),
                    child: SizedBox(
                      height: screenHeight * 0.09,
                      child: TextFormField(
                        controller: name,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          labelText: "Enter your name",
                          hintText: "John Doe",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Email Input Field
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.01,
                    ),
                    child: SizedBox(
                      height: screenHeight * 0.09,
                      child: TextFormField(
                        controller: email,
                        validator: (value) {
                          RegExp emailRegex =
                              RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$');
                          if (value!.isEmpty) {
                            return "Email is required";
                          } else if (!emailRegex.hasMatch(value)) {
                            return "Enter a valid email address";
                          }
                          return null;
                        },
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: "Enter your email",
                          hintText: "example@example.com",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Password Input Field
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.01,
                    ),
                    child: SizedBox(
                      height: screenHeight * 0.09,
                      child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Password is required";
                          } else if (value.length < 8) {
                            return "Password must be at least 8 characters long";
                          } else if (!RegExp(
                                  r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$')
                              .hasMatch(value)) {
                            return 'At least 1 uppercase lowercase, 1 No, and 1 Special Char ';
                          }
                          return null;
                        },
                        keyboardType: TextInputType.visiblePassword,
                        obscureText: _isPasswordHidden,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordHidden = !_isPasswordHidden;
                              });
                            },
                          ),
                          labelText: "Enter your passwords",
                          hintText: "Password",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  // Submit Button
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.02,
                    ),
                    child: SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            RegsisterUser();
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 13, 31, 148),
                          textStyle: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text("Sign Up"),
                      ),
                    ),
                  ),
                  // signin button for redirect to login page
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.04,
                      vertical: screenHeight * 0.001,
                    ),
                    child: SizedBox(
                      width: screenWidth,
                      height: screenHeight * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Signin()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 13, 31, 148),
                          textStyle: TextStyle(
                            fontSize: screenWidth * 0.05,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        child: Text("Sign In"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
