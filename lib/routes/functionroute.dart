import 'package:contactapp/UI/homescreen.dart';
import 'package:flutter/material.dart';

import '../UI/favscreen.dart';
import 'routename.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case Routename.homeScreen:
      return MaterialPageRoute(builder: (context) =>  Homescreen());
    case Routename.favourite:
      return MaterialPageRoute(builder: (context) => const FavouriteScreen());
    default:
      return null;
  }
}
