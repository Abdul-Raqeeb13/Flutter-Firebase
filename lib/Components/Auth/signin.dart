// ignore_for_file: prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Signin extends StatefulWidget {
  const Signin({Key? key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  bool _isPasswordHidden = true;

  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  GlobalKey<FormState> _form = GlobalKey<FormState>();
  var uid;
  Future<void> SigninUser() async {
    print(email.text);
    print(password.text);
    try {
      final userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: email.text, password: password.text);
      final user = userCredential.user;
      print(user?.uid);
      print('login success');
    }  on FirebaseAuthException catch (e) {
    print("Error: ${e.message}"); // Print error in console
    showMessageToUser(e.message); // Show error to user
  }
  }
  void showMessageToUser(String? message) {
  // You can use a Flutter Snackbar, Dialog, or Toast
  if (message != null) {
  ScaffoldMessenger.of(context).showSnackBar(
  SnackBar(
    content: Text(
      message,
      style: TextStyle(
        fontSize: 12, 
        fontWeight: FontWeight.bold, 
        color: Colors.white, // Text color
      ),
    ),
    backgroundColor: Colors.red, // Background color
    behavior: SnackBarBehavior.floating, // Floating style
    margin: EdgeInsets.all(16), // Margin around the snackbar
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(12), // Rounded corners
    ),
    duration: Duration(seconds: 3), // Duration before auto-dismiss
    action: SnackBarAction(
      label: 'OK',
      textColor: Colors.yellow, // Action button color
      onPressed: () {
        // Handle action (optional)
      },
    ),
  ),
);
  }
}

  @override
  Widget build(BuildContext context) {
    // Get screen dimensions
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("SIGNIN FORM"),
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
                  Container(
                    height: screenHeight * 0.40,
                    width: screenWidth,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                      ),
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://img.freepik.com/free-vector/turquoise-circles-background_1128-53.jpg?ga=GA1.1.881659082.1730823737&semt=ais_hybrid",
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
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
                              "Sign In",
                              style: TextStyle(
                                fontSize: screenWidth * 0.06,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              "Fill the form below to login your account",
                              style: TextStyle(fontSize: screenWidth * 0.04),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Name Input Field
                 
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
                            SigninUser();
                          }
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
