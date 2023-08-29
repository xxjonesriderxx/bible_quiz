import 'package:bible_quiz/helper/Constants.dart';
import 'package:flutter/cupertino.dart';

class DeviceTypeHelper {
  static EdgeInsets getRootContainerPadding(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    if (deviceIsPhone(context)) {
      return currentOrientation == Orientation.landscape ? Constants.rootContainerPaddingSmartphoneLandscape : Constants.rootContainerPaddingSmartphonePortrait;
    } else {
      return currentOrientation == Orientation.landscape ? Constants.rootContainerPaddingTabletLandscape : Constants.rootContainerPaddingTabletPortrait;
    }
  }

  static bool deviceIsPhone(BuildContext context) {
    return MediaQuery.of(context).size.shortestSide < 600.0;
  }

  static bool deviceIsTablet(BuildContext context) {
    return !deviceIsPhone(context);
  }
}
