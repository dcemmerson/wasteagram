import 'package:flutter/material.dart';

/// filename: sizing.dart
/// description: Utility class used to calculate
class Sizing {
  static Size byPercentages(
      {@required double widthPercentage,
      @required double heightPercentage,
      @required BuildContext context}) {
    assert(widthPercentage >= 0 && widthPercentage <= 100);
    assert(heightPercentage >= 0 && heightPercentage <= 100);

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Size(
        width: screenWidth * widthPercentage / 100,
        height: screenHeight * heightPercentage / 100);
  }
}

class Size {
  final double width;
  final double height;

  Size({@required this.width, @required this.height});
}
