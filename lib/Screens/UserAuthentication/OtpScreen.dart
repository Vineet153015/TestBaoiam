import 'package:flutter/material.dart';
import 'package:testbaoiam/Screens/ScreenSize.dart';
import 'package:flutter/services.dart';

import 'package:flutter_svg/svg.dart';
import 'package:testbaoiam/Screens/UserAuthentication/ForgetPassword.dart';

final _formKey = GlobalKey<FormState>();
TextEditingController _otp = TextEditingController();


void _submitForm() {
  if (_formKey.currentState?.validate() ?? false) {
    _formKey.currentState?.save();
    // Handle form submission logic (e.g., API call)
    // print('Name: $_email');
  }
}

class OtpScreen extends StatelessWidget {
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
                        Image.asset(
                          'assets/images/otp.jpg', 
                            height: screenSizeHelper.blockSizeVertical * 30,
                        ),
                        SizedBox(
                            height: screenSizeHelper.blockSizeHorizontal * 10),
                        Text(
                          "OTP Verification",
                          style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w300,
                              color: Color(0xFF010144)),
                        ),
                        SizedBox(
                            height: screenSizeHelper.blockSizeHorizontal * 3),
                        Text(
                          "Enter OTP sent to your email",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              fontSize: screenSizeHelper.blockSizeHorizontal * 5,
                              fontWeight: FontWeight.w300,
                              color: Colors.grey[800]),
                        ),
                        SizedBox(
                            height: screenSizeHelper.blockSizeHorizontal * 3),
                        Form(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 48,
                                height: 48,
                                child: TextFormField(
                                  onChanged: (value){
                                    if(value.length == 1){
                                      FocusScope.of(context).nextFocus();
                                    }
                                    else if (value.isEmpty) {
                                      FocusScope.of(context).previousFocus(); // Move to previous field
                                    }
                                  },
                                  style: Theme.of(context).textTheme.headlineMedium,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 48,
                                height: 48,
                                child: TextFormField(
                                  onChanged: (value){
                                    if(value.length == 1){
                                      FocusScope.of(context).nextFocus();
                                    }
                                    else if (value.isEmpty) {
                                      FocusScope.of(context).previousFocus(); // Move to previous field
                                    }
                                  },
                                  style: Theme.of(context).textTheme.headlineMedium,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 48,
                                height: 48,
                                child: TextFormField(
                                  onChanged: (value){
                                    if(value.length == 1){
                                      FocusScope.of(context).nextFocus();
                                    }
                                    else if (value.isEmpty) {
                                      FocusScope.of(context).previousFocus(); // Move to previous field
                                    }
                                  },
                                  style: Theme.of(context).textTheme.headlineMedium,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 48,
                                height: 48,
                                child: TextFormField(
                                  onChanged: (value){
                                    if(value.length == 1){
                                      FocusScope.of(context).nextFocus();
                                    }
                                    else if (value.isEmpty) {
                                      FocusScope.of(context).previousFocus(); // Move to previous field
                                    }
                                  },
                                  style: Theme.of(context).textTheme.headlineMedium,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 48,
                                height: 48,
                                child: TextFormField(
                                  onChanged: (value){
                                    if(value.length == 1){
                                      FocusScope.of(context).nextFocus();
                                    }
                                    else if (value.isEmpty) {
                                      FocusScope.of(context).previousFocus(); // Move to previous field
                                    }
                                  },
                                  style: Theme.of(context).textTheme.headlineMedium,
                                  keyboardType: TextInputType.number,
                                  textAlign: TextAlign.center,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(1),
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: screenSizeHelper.blockSizeHorizontal * 10),
                        ElevatedButton(
                          onPressed: () {
                            // Navigator.pushReplacement(
                            //     context,
                            //     MaterialPageRoute(builder: (context) => welcomePage2())
                            // );
                          },
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
                              'Verify',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                                fontWeight: FontWeight.bold, // Optional: Make the text bold
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 10), // Add some space between the TextFormField and the clickable text
                        Align(
                          alignment: Alignment.center, // Align text to the right
                          child: GestureDetector(
                            onTap: () {
                              // Handle the "Forgot Password" click event here
                              print("Forgot Password clicked");
                              // You can navigate to a different page or show a dialog
                            },
                            child: Text(
                              "Resend",
                              style: TextStyle(
                                  color: Colors.grey, // Color for the text
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18// Bold text
                                // Underline text
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
