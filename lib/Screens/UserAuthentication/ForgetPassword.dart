import 'package:testbaoiam/Screens/UserAuthentication/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:testbaoiam/Screens/ScreenSize.dart';
import 'package:flutter_svg/svg.dart';

import 'package:fluttertoast/fluttertoast.dart';

class ForgetPassword extends StatefulWidget {
  @override
  State<ForgetPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgetPassword> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _emailController = TextEditingController();
  final auth = FirebaseAuth.instance;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void sendResetLink() {
    // Extract email from the controller and trim spaces
    final email = _emailController.text.trim();

    // Attempt to send a password reset email
    auth
        .sendPasswordResetEmail(email: email)
        .then((onValue) {
      // Success: Email was sent
      Fluttertoast.showToast(
        msg: "Email sent successfully to your registered email.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => SignIn())
      );
    }).catchError((error) {
      // Handle errors when sending email
      String errorMessage;

      if (error is FirebaseAuthException) {
        switch (error.code) {
          case 'invalid-email':
            errorMessage = "The email address is not valid.";
            break;
          case 'user-not-found':
            errorMessage =
            "No user found for that email. Please register yourself.";
            break;
          default:
            errorMessage = "An error occurred. Please try again.";
        }
      } else {
        errorMessage = "An unexpected error occurred.";
      }

      // Show the error message using a toast
      Fluttertoast.showToast(
        msg: errorMessage,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
            padding: EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                            height: screenSizeHelper.blockSizeHorizontal * 40),
                        SvgPicture.asset(
                          'assets/images/forgotPass.svg',
                          width: screenSizeHelper.blockSizeHorizontal * 30,
                          height: screenSizeHelper.blockSizeVertical * 30,
                        ),
                        SizedBox(
                            height: screenSizeHelper.blockSizeHorizontal * 10),
                        Text(
                          "Forgot Password?",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF010144)),
                        ),
                        SizedBox(
                            height: screenSizeHelper.blockSizeHorizontal * 3),
                        Text(
                          "Enter your registered email\nto send an OTP to reset your password.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize:
                                  screenSizeHelper.blockSizeHorizontal * 5,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[800]),
                        ),
                        SizedBox(
                            height: screenSizeHelper.blockSizeHorizontal * 3),
                        Form(
                          key: _formKey,
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Color(
                                      0xFFF2F2F2), // Grey background color
                                  borderRadius: BorderRadius.circular(
                                      10), // Rounded corners
                                ),
                                child: TextFormField(
                                  controller: _emailController,
                                  decoration: const InputDecoration(
                                    hintText: "Email",
                                    border:
                                        InputBorder.none, // Remove the border
                                    enabledBorder:
                                        InputBorder.none, // Remove the border
                                    focusedBorder:
                                        InputBorder.none, // Remove the border
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                        vertical:
                                            15), // Adjust padding as needed
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your name';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: screenSizeHelper.blockSizeHorizontal * 5),
                        ElevatedButton(
                          onPressed: () {
                            sendResetLink();
                          },
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                              screenSizeHelper.blockSizeHorizontal *
                                  80, // 80% of screen width
                              screenSizeHelper.blockSizeVertical *
                                  5, // 10% of screen height
                            ),
                            backgroundColor: Colors
                                .transparent, // Set background to transparent
                            shadowColor: Colors.transparent, // Remove shadow
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Container(
                            alignment: Alignment.center, // Center the text
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              gradient: const LinearGradient(
                                colors: <Color>[
                                  Color(0xFFFFC700),
                                  Color(0xFFFF0000),
                                ],
                              ),
                            ),
                            child: const Text(
                              'Send Link',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight
                                    .bold, // Optional: Make the text bold
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
