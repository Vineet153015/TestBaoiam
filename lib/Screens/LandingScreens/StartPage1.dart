import 'package:testbaoiam/Screens/LandingScreens/StartPage2.dart';
import 'package:flutter/material.dart';
import 'package:testbaoiam/Screens/ScreenSize.dart';
import 'package:flutter_svg/svg.dart';

class welcomePage extends StatelessWidget {
  final LinearGradient _gradient = const LinearGradient(
    colors: <Color>[Colors.yellow, Colors.red],
  );

  @override
  Widget build(BuildContext context) {
    final screenSizeHelper = ScreenSizeHelper.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          // Add Padding widget here
          padding: EdgeInsets.only(
            top: screenSizeHelper.blockSizeVertical * 5,
            left: screenSizeHelper.blockSizeHorizontal * 4,
          ), //Adjust values as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ShaderMask(
                        shaderCallback: (Rect rect) {
                          return _gradient.createShader(rect);
                        },
                        child: Text(
                          "Welcome",
                          style: TextStyle(
                            fontSize: screenSizeHelper.blockSizeHorizontal * 15,
                            fontFamily: 'Roboto',
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        "We’re glad that you\nare here",
                        style: TextStyle(
                          fontSize: screenSizeHelper.blockSizeHorizontal * 8,
                          fontFamily: 'Roboto',
                          fontWeight: FontWeight.normal,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              // SizedBox(height: screenSizeHelper.blockSizeVertical * 5),
              Stack(
                alignment: Alignment.center, // Center the child within the Stack
                children: [
                  SvgPicture.asset(
                    'assets/images/girlBg.svg',
                    width: screenSizeHelper.blockSizeHorizontal *60,
                    height: screenSizeHelper.blockSizeVertical * 60,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 35),
                    child: Image.asset('assets/images/girl.png',
                      width: 350,
                      height: 300,
                    ),
                  ), // Replace with your image path
                ],
              ),
              SizedBox(height: screenSizeHelper.blockSizeHorizontal*5),
              Center(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context, 
                        MaterialPageRoute(builder: (context) => welcomePage2())
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
                      'Next',
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
