
import 'package:testbaoiam/Screens/Home/Dashboard.dart';
import 'package:testbaoiam/Screens/UserAuthentication/ForgetPassword.dart';
import 'package:flutter/material.dart';
import 'package:testbaoiam/Screens/ScreenSize.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';



class SignIn extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<SignIn> {
  // final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onLoginSuccess() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true);

    // Navigate to the home page
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => Dashboard()),
    );
  }

  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        if (userCredential.user != null) {
          Fluttertoast.showToast(
            msg: "Login successful!",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.grey,
            textColor: Colors.white,
            fontSize: 16.0,
          );
          _onLoginSuccess();
        }
      } on FirebaseAuthException catch (e) {
        String errorMessage;
        switch (e.code) {
          case 'invalid-email':
            errorMessage = "The email address is not valid.";
            break;
          case 'user-not-found':
            errorMessage = "No user found for that email.";
            break;
          case 'wrong-password':
            errorMessage = "Wrong password provided.";
            break;
          default:
            errorMessage = e.message ?? "An error occurred";
        }
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } catch (e) {
        // Handle any other types of exceptions
        Fluttertoast.showToast(
          msg: "An unexpected error occurred.",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }


  bool isValidEmail(String input) {
    final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$",
    );
    return emailRegex.hasMatch(input);
  }

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Column(
                    children: [
                      SizedBox(
                          height: screenSizeHelper.blockSizeHorizontal * 10),
                      Image.asset(
                        'assets/logo/baoiam_logo.png', // Replace with your logo URL
                        height: 100,
                      ),
                      SizedBox(
                          height: screenSizeHelper.blockSizeHorizontal * 10),
                      const Text(
                        'Sign In',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF010144),
                        ),
                      ),
                      SizedBox(
                          height: screenSizeHelper.blockSizeHorizontal * 10),
                    ],
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2), // Grey background color
                          borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: "Email",
                            border: InputBorder.none, // Remove the border
                            enabledBorder:
                            InputBorder.none, // Remove the border
                            focusedBorder:
                            InputBorder.none, // Remove the border
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ), // Adjust padding as needed
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email';
                            } else if (!value.endsWith('@gmail.com')) {
                              return 'Email must be a valid Gmail address (@gmail.com)';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFF2F2F2), // Grey background color
                          borderRadius:
                          BorderRadius.circular(10), // Rounded corners
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            hintText: "Password",
                            border: InputBorder.none, // Remove the border
                            enabledBorder:
                            InputBorder.none, // Remove the border
                            focusedBorder:
                            InputBorder.none, // Remove the border
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 15,
                            ), // Adjust padding as needed
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                        ),
                      ),




                      // FORGOT PASSWORD


                      SizedBox(height: 10), // Add some space between the TextFormField and the clickable text
                      Align(
                        alignment: Alignment.centerRight, // Align text to the right
                        child: GestureDetector(
                          onTap: () {
                            // Handle the "Forgot Password" click event here
                            Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(builder: (context) => ForgetPassword())
                                );
                            // You can navigate to a different page or show a dialog
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(
                              color: Colors.grey, // Color for the text
                              fontWeight: FontWeight.bold,
                              fontSize: 14// Bold text
                               // Underline text
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _signIn,
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(
                            screenSizeHelper.blockSizeHorizontal * 80, // 80% of screen width
                            screenSizeHelper.blockSizeVertical * 5, // 10% of screen height
                          ),
                          backgroundColor: Colors.transparent, // Set background to transparent
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
                            'Login',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight.bold, // Optional: Make the text bold
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Text(
                              'Or Login with',
                              style: TextStyle(color: Colors.grey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              color: Colors.grey,
                              height: 1.5,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     IconButton(
                      //       icon: Image.network('https://your_google_icon_url_here.png'), // Replace with Google icon URL
                      //       onPressed: () {},
                      //     ),
                      //     IconButton(
                      //       icon: Image.network('https://your_apple_icon_url_here.png'), // Replace with Apple icon URL
                      //       onPressed: () {},
                      //     ),
                      //     IconButton(
                      //       icon: Image.network('https://your_facebook_icon_url_here.png'), // Replace with Facebook icon URL
                      //       onPressed: () {},
                      //     ),
                      //   ],
                      // ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Don't have an account?"),
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              'Register',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
