import 'package:flutter/material.dart';

import '../../core/values/colors.dart';
import '../../core/values/icons.dart';

List<Icon> getIcons() {
  return const [
    Icon(
      IconData(personIcon, fontFamily: 'MaterialIcons'),
      color: kPurpleColor,
    ),
    Icon(IconData(workIcon, fontFamily: 'MaterialIcons'), color: kPinkColor),
    Icon(IconData(movieIcon, fontFamily: 'MaterialIcons'), color: kGreenColor),
    Icon(IconData(sportIcon, fontFamily: 'MaterialIcons'), color: kYellowColor),
    Icon(IconData(travelIcon, fontFamily: 'MaterialIcons'),
        color: kDeepPinkColor),
    Icon(IconData(shopIcon, fontFamily: 'MaterialIcons'),
        color: kLightBlueColor),
  ];
}
