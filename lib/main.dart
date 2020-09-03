import 'package:flutter/material.dart';

import 'pages/about.dart';
import 'pages/detail_article.dart';
import 'pages/home.dart';

void main() => runApp(MaterialApp(
  home: Home(),
  debugShowCheckedModeBanner: false,
  theme: ThemeData(fontFamily: 'Circular Std'),

  routes: {
    '/home' : (BuildContext context) => Home(),
    '/about' : (BuildContext context) => About(),
    '/details' : (BuildContext context) => Details(),
  },
));