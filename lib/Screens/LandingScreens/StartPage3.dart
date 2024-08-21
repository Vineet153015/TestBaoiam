
import 'package:testbaoiam/Screens/UserAuthentication/Registration.dart';
import 'package:flutter/material.dart';
import 'package:testbaoiam/Screens/ScreenSize.dart';
import 'package:flutter_svg/svg.dart';

class welcomePage3 extends StatelessWidget{



  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(
            top: screenSizeHelper.blockSizeVertical * 5,
            left: screenSizeHelper.blockSizeHorizontal * 4,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add your images here
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: Image.asset(
                    'assets/logo/baoiam_logo.png',
                    width: screenSizeHelper.blockSizeHorizontal *50,
                    // height: screenSizeHelper.blockSizeHorizontal *50,
                  ),
                ),
              ),
              Center(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/images/trophy.svg",
                      width: screenSizeHelper.blockSizeHorizontal * 120,
                      height: screenSizeHelper.blockSizeHorizontal * 120,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 115),
                      child: Image.asset(
                        'assets/images/trophygirl.jpg',
                        width: screenSizeHelper.blockSizeHorizontal *100,
                        height: screenSizeHelper.blockSizeHorizontal *100,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenSizeHelper.blockSizeHorizontal*5),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => RegisterPage())
                    );
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
                      'Start Learning',
                      style: TextStyle(
                        fontSize: 25,
                        color: Colors.white,
                        fontWeight: FontWeight.bold, // Optional: Make the text bold
                      ),
                    ),
                  ),
                ),
              )

            ],
          ),
        ),
      ),
    );
  }
}