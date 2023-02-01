import 'package:flutter/material.dart';

import 'order.dart';

void main() {
  runApp(
    MaterialApp(
      title: "introduction App",
      home: order(),
      theme: ThemeData(
        brightness: Brightness.light,
        // primarySwatch: Colors.pink,
      ),
    ),
  );
}
