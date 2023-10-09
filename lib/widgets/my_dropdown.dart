import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants.dart';
import '../provider/count.dart';

class MyDropdown extends StatefulWidget {
  final String name;
  const MyDropdown({super.key, required this.name});
  @override
  _MyDropdownState createState() => _MyDropdownState();
}

class _MyDropdownState extends State<MyDropdown> {

  @override
  Widget build(BuildContext context) {
    return Consumer<Value>(
      builder:(context, val, child)=> DropdownButton<String>(
        borderRadius: BorderRadius.circular(20),
        iconSize: 0,
        value: value,
        onChanged: (String? newValue) {
          setState(() {
            value = newValue!;
            val.changeVal;
            index = list.indexWhere((val) => val == newValue);
          });
          // Navigator.of(context).pop(TeamList(name: widget.name));
          // Navigator.push(context, MaterialPageRoute(builder: (context)=> TeamList(name: widget.name)));
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
      ),
    );
  }
}

