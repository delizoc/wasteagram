import 'package:flutter/material.dart';
import 'package:wasteagram/screens/waste_list_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){
    return MaterialApp(
      title: 'Wasteagram',
      theme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blue,
      ),
      home: const WasteList(title: 'Wasteagram'),
    );
  }
}
