import 'package:testbaoiam/Firebase_auth_implementation/firebase_auth_services.dart';
import 'package:testbaoiam/Screens/UserAuthentication/LoginSuccess.dart';
import 'package:testbaoiam/Screens/UserAuthentication/SignIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:testbaoiam/Screens/ScreenSize.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final FirebaseAuthServices _auth = FirebaseAuthServices();

  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  String? _password = "";
  String? _confirmPass = "";

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmpasswordController.dispose();
    super.dispose();
  }

  void _register() async {
    // String name = _nameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    User? user = await _auth.createWithEmailAndPassword(email, password);
    if (user != null) {

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginSuccessScreen())
      );
    } else {
      showError(String errorMessage) {
        // Print the error to the terminal
        print('Error is this damn thing : $errorMessage');

        // Show the error as a toast
        Fluttertoast.showToast(
          msg: errorMessage,
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.grey,
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

  bool isValidPhoneNumber(String input) {
    final RegExp phoneRegex = RegExp(
      r"^\d{10}$", // Assumes phone number is 10 digits
    );
    return phoneRegex.hasMatch(input);
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
                        'Create an Account',
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
                          controller: _nameController,
                          decoration: const InputDecoration(
                            hintText: "Name",
                            border: InputBorder.none, // Remove the border
                            enabledBorder:
                                InputBorder.none, // Remove the border
                            focusedBorder:
                                InputBorder.none, // Remove the border
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 15), // Adjust padding as needed
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your name';
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
                              return 'Please enter your email or phone number';
                            } else if (isValidEmail(value)) {
                              // The input is a valid email
                              if (!value.endsWith('@gmail.com')) {
                                return 'Email must be a valid Gmail address (@gmail.com)';
                              }
                            } else if (isValidPhoneNumber(value)) {
                              // The input is a valid phone number
                              return null;
                            } else {
                              return 'Please enter a valid email or phone number';
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
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your password';
                            }
                            if (value.length < 6) {
                              return 'Password must be at least 6 characters long';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _password = value?? '';
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
                          controller: _confirmpasswordController,
                          decoration: const InputDecoration(
                            hintText: "Confirm Password",
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
                          onSaved: (value) {
                            _confirmPass = value;
                          },
                          obscureText: true,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (_confirmPass != _password) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },

                        ),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: _register,
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
                            'Create',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.white,
                              fontWeight: FontWeight
                                  .bold, // Optional: Make the text bold
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
                          Text('Already have an account?'),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => SignIn()));
                            },
                            child: Text(
                              'Sign in',
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
