import 'package:flutter/material.dart';
import 'package:treasure/home_page.dart';
import '../constants.dart';

class MyDropdown extends StatefulWidget {
  const MyDropdown({super.key});
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return DropdownButton<String>(
      borderRadius: BorderRadius.circular(20),
      iconSize: 0,
      value: value,
      onChanged: (String? newValue) {
        setState(() {
          value = newValue!;
          index = list.indexWhere((val) => val == newValue);
        });
        Navigator.push(context, MaterialPageRoute(builder: (context)=> MyHomePage()));
        print('$value $index');
      },
      items: list.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Container(
            alignment: Alignment.center,
              height:35,
              width: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.blue[100],
              ),
              child: Text(value),
          ),
        );
      }).toList(),
    );
  }
}
