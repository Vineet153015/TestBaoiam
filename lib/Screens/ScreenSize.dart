
import 'package:flutter/widgets.dart';

class ScreenSizeHelper {
  final double screenWidth;
  final double screenHeight;
  final double blockSizeHorizontal;
  final double blockSizeVertical;

  ScreenSizeHelper._({
    required this.screenWidth,
    required this.screenHeight,
    required this.blockSizeHorizontal,
    required this.blockSizeVertical,
  });

  factory ScreenSizeHelper.of(BuildContext context) {
    final MediaQueryData mediaQueryData = MediaQuery.of(context);
    // Screen Width (Chaoudai)
    final double screenWidth = mediaQueryData.size.width;
    // Screen Height (Lambai)
    final double screenHeight = mediaQueryData.size.height;
    // Block Height (Width, chaudai)
    final double blockSizeHorizontal = screenWidth / 100;
    // Block length (lambai)
    final double blockSizeVertical = screenHeight / 100;

    return ScreenSizeHelper._(
      screenHeight: screenHeight,
      screenWidth: screenWidth,
      blockSizeHorizontal: blockSizeHorizontal,
      blockSizeVertical: blockSizeVertical,
    );
  }
}
