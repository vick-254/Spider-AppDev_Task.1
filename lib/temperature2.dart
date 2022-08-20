import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';
import 'package:vibration/vibration.dart';

class temperature extends StatefulWidget {
  const temperature({Key? key}) : super(key: key);

  @override
  State<temperature> createState() => _temperatureState();
}

class _temperatureState extends State<temperature> {
  @override
  void initState(){

    userInput=0;
    super.initState();
  }

  final List<String> tempunits = [

    '°C',
    '°F',
    'Kelvin'
  ];


  void successToast() => Fluttertoast.showToast(
    msg:"Verifying...",
    fontSize: 18,
    backgroundColor: Colors.grey,
    textColor: Colors.white,

  );

  void cancelToast() => Fluttertoast.showToast(
    msg:"Failed. Please Enter a Valid Input",
    fontSize: 18,
    backgroundColor: Colors.grey,
    textColor: Colors.white,

  );





  double convert (double value,String? from, String? to)
  {
    double result = 0;


    if(from !=null && to !=null) {
      if (from == '°C') {
        if (to == '°F') {
          result = (value * 9 / 5) + 32;
        }
        else if (to == 'Kelvin') {
          result = (value + 273.15);
        }
        else
          result = value;
      }
      else if (from == 'Kelvin') {
        if (to == '°C') {
          result = (value - 273.15);
        }
        else if (to == '°F') {
          result = (1.8) * (value - 273.15) + 32;
        }
        else
          result = value;
      }
      else if (from == '°F') {
        if (to == '°C') {
          result = (value - 32) * 5 / 9;
        }
        else if (to == 'Kelvin') {
          result = ((value - 32) * 5 / 9) + 273.15;
        }
        else
          result = value;
      }
      resultText = '${userInput.toString()} $_startMeasures  --->  ${result
          .toString()} $_convertMeasures';
      setState(() {
        resultText=resultText;
      });

      successToast();
      return result;
    }
    else
      cancelToast();
      return 0;







  }

  late double resultOut;

  late double userInput;
  late double userOutput;
  String? _startMeasures;
  String? _convertMeasures;
  String? resultText;




  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30),
            child: Column(
              children: [
                Text('Temperature Checker', style: TextStyle(
                    fontSize: 35, color: Colors.black
                ),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,5}')),
                    ],
                    onChanged: (text){

                      var input=double.tryParse(text);
                      if (input !=null)
                        setState(() {
                          userInput=input;
                        });


                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black26,
                      hintText: 'Enter the Temperature',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 0,
                ),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DropdownButton<String>(
                      value: _startMeasures,
                      isExpanded: false,
                      dropdownColor: Colors.white,
                      style: TextStyle(fontSize: 17, color: Colors.black),
                      hint: Text('Choose a Unit', style: TextStyle(fontSize: 15,)),
                      items: tempunits.map((String value){
                        return  DropdownMenuItem(value: value,
                          child: Text(value),);

                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          _startMeasures=value;
                        });
                      },
                    ),
                    Text('To', style: TextStyle(fontSize: 25, color: Colors.black),),
                    DropdownButton<String>(
                      value: _convertMeasures,
                      isExpanded: false,
                      dropdownColor: Colors.white,
                      style: TextStyle(fontSize: 17, color: Colors.black),
                      hint: Text('Choose a Unit', style: TextStyle(fontSize: 15,)),
                      items: tempunits.map((String value){
                        return  DropdownMenuItem(value: value,
                          child: Text(value),);

                      }).toList(),
                      onChanged: (value){
                        setState(() {
                          _convertMeasures=value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(
                  height: 0,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 40),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d{0,5}')),
                    ],
                    onChanged: (text){

                      var input=double.tryParse(text);
                      if (input !=null)
                        setState(() {
                          userOutput=input;
                        });


                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.black26,
                      hintText: 'Enter the Temperature',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10,),
                TextButton(
                  onPressed: (){


                    resultOut=convert(userInput,_startMeasures,_convertMeasures);
                    if (resultOut == userOutput) {
                      showDialog(
                        context: context,
                        builder: (context) =>
                            AlertDialog(
                              backgroundColor: Colors.green,
                              title: const Text('!!!!   CORRECT   !!!!'),
                              content: const Text(
                                  'You have entered the correct answer!'
                              ),
                              actions: [
                                TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('OK')
                                ),
                              ],
                            ),

                      );
                    }

                    else{
                      Vibration.vibrate();
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          backgroundColor: Colors.red,
                          title: const Text('!!!!   INCORRECT   !!!!'),
                          content: const Text(
                              'Sorry. The correct answer will be displayed below:'
                          ),

                          actions: [
                            TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK')
                            ),
                          ],
                        ),

                      );

                    }


                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 180,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.teal,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text('Verify', style: TextStyle(
                        fontWeight: FontWeight.w700, fontSize: 25, color: Colors.white
                    ),),
                  ),
                ),
                SizedBox(height: 25,),
                Text(resultText??"Enter a Valid Input",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                )




              ],
            ),
          ),
        ),

      ),


    );

  }
}
