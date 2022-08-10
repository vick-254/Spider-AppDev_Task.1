import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

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



  void cancelToast() => Fluttertoast.showToast(
    msg:"Failed. Please Enter a Valid Input",
    fontSize: 18,
    backgroundColor: Colors.grey,
    textColor: Colors.white,

  );

  void successToast() => Fluttertoast.showToast(
    msg:"Successfully Converted",
    fontSize: 18,
    backgroundColor: Colors.grey,
    textColor: Colors.white,

  );



  void convert (double value,String? from, String? to)
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

      successToast();
    }
    else
      cancelToast();





    setState(() {
      resultText=resultText;
    });

  }



  late double userInput;
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
                Text('Temperature Converter', style: TextStyle(
                  fontSize: 35, color: Colors.black
                ),),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 40),
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
                  height: 10,
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
                SizedBox(height: 30,),
                TextButton(
                  onPressed: (){


                    convert(userInput,_startMeasures,_convertMeasures);
                  },
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    width: 180,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        borderRadius: BorderRadius.circular(20),
                      ),
                  child: Text('Convert', style: TextStyle(
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


