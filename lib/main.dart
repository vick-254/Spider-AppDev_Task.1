
import 'package:flutter/material.dart';
import 'package:unit_converter_spider/custom_icons_icons.dart';
import 'package:unit_converter_spider/temperature.dart';
import 'package:unit_converter_spider/length.dart';
import 'package:unit_converter_spider/weight.dart';
import 'package:unit_converter_spider/speed.dart';
import 'package:unit_converter_spider/conversionCheck.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {

  FlutterNativeSplash.removeAfter(initialization,);
  runApp(const myApp());

}

Future initialization(BuildContext? context)async{
  await Future.delayed(Duration (seconds: 3));
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home :Converter(),
    );
  }
}

class Converter extends StatefulWidget {
  const Converter({Key? key}) : super(key: key);

  @override
  State<Converter> createState() => _ConverterState();
}

class _ConverterState extends State<Converter> {

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
        title: const Text('Units Converter'),
        centerTitle: true,
        backgroundColor: Colors.teal,
        elevation: 15,
        actions: [
          IconButton(
              onPressed: (){
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
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
            icon : Icon(CustomIcons.temperature_high),
            label: "Temperature",

          ),
          BottomNavigationBarItem(
            icon : Icon(CustomIcons.ruler),
            label: 'Length',
          ),
          BottomNavigationBarItem(
            icon : Icon(CustomIcons.balance_scale),
            label: "Weight",
          ),
          BottomNavigationBarItem(
            icon : Icon(CustomIcons.directions_bike),
            label: "Speed",
          ),
        ],
        onTap:(current_Index) {
          setState(() {
            index = current_Index;
          });
        },
      ),
      drawer: Drawer(
        elevation: 16,

        child: Column(
          children: <Widget>[

            UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  color: Colors.teal,
                ),
                accountName: Text(
                    'Units Converter',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),


                accountEmail: Text('v1.0')),
            ListTile(
              title: Text('Conversion Checker'),
              onTap: (){
                Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context)=> conversionCheck()
                  )
                );
              },




            ),
            Divider(
              height: 0.1,
            ),

          ],
        ),
      ),

    );
  }
}




