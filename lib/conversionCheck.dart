import 'package:flutter/material.dart';
import 'package:unit_converter_spider/custom_icons_icons.dart';
import 'package:unit_converter_spider/temperature2.dart';
import 'package:unit_converter_spider/length2.dart';
import 'package:unit_converter_spider/weight2.dart';
import 'package:unit_converter_spider/speed2.dart';


class conversionCheck extends StatefulWidget {
  const conversionCheck({Key? key}) : super(key: key);

  @override
  State<conversionCheck> createState() => _conversionCheckState();
}

class _conversionCheckState extends State<conversionCheck> {

  int index = 0;
  final List<Widget> _children = [

    temperature(),
    length(),
    weight(),
    speed(),


  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: AppBar(
        title: const Text('Conversion Checker'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 15,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) =>
                    AlertDialog(
                      title: const Text('About'),
                      content: const Text(
                          'This app was developed for Spider Inductions Task 1 by Vignesh, a second year undergrad student at NIT Trichy.'
                      ),
                      actions: [
                        TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK')
                        ),
                      ],
                    ),

              );
            },
            icon: const Icon(Icons.account_circle_sharp),
          )
        ],
      ),

      body: _children[index],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.temperature_high),
            label: "Temperature",

          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.ruler),
            label: 'Length',
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.balance_scale),
            label: "Weight",
          ),
          BottomNavigationBarItem(
            icon: Icon(CustomIcons.directions_bike),
            label: "Speed",
          ),
        ],
        onTap: (current_Index) {
          setState(() {
            index = current_Index;
          });
        },
      ),

    );
  }
}
