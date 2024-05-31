

import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Color selectedColor = Colors.white;

  void pickColor(Color color) {
    setState(() {
      selectedColor = color;
    });
  }

  void changeBackground() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Color Picker'),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            ColorPicker(
              pickerColor: selectedColor,
              onColorChanged: pickColor,
            ),
            ElevatedButton(
              onPressed: changeBackground,
              child: Text('Change Background'),
            ),
            Expanded(
              child: Container(
                color: selectedColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
