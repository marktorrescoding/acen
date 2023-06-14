import 'package:flutter/material.dart';
import 'package:openbeta/pages/home_page/home_page.dart';

class Routes {
  static const String home = '/home';

  static Map<String, WidgetBuilder> get routes {
    return {
      home: (context) => HomePage(),
      // Add more routes here if needed
    };
  }
}
