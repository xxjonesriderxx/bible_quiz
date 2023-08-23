import 'package:bible_quiz/helper/Constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_device_type/flutter_device_type.dart';

class DeviceTypeHelper {
  static EdgeInsets getRootContainerPadding(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    if (Device.get().isTablet) {
      return currentOrientation == Orientation.landscape ? Constants.rootContainerPaddingTabletLandscape : Constants.rootContainerPaddingTabletPortrait;
    } else {
      return currentOrientation == Orientation.landscape ? Constants.rootContainerPaddingSmartphoneLandscape : Constants.rootContainerPaddingSmartphonePortrait;
    }
  }
}
