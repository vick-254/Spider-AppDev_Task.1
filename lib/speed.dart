import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/services.dart';

class speed extends StatefulWidget {
  const speed({Key? key}) : super(key: key);

  @override
  State<speed> createState() => _speedState();
}

class _speedState extends State<speed> {
  @override
  void initState(){

    userInput=0;
    super.initState();
  }

  final List<String> tempunits = [

    'km/hr',
    'm/s',
    'in/s (inch/s)',
    'mile/hr',

  ];

  final Map<String,int> nameMapping
  ={
    'km/hr':0,
    'm/s':1,
    'in/s (inch/s)':2,
    'mile/hr':3,

  };

  dynamic formulas ={
    '0':[1,0.2777,0.0006213,10.9361],
    '1':[3.6,1,39.37,2.23694],
    '2':[0.09144,0.0254,1,0.0568182],
    '3':[1.60934,0.44704,17.6,1],

  };
  void successToast() => Fluttertoast.showToast(
    msg:"Successfully Converted",
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

  void convert (double value,String? from, String? to)
  {
    if(from !=null && to !=null) {
      int? unitFro = nameMapping[from];
      int? unitTo = nameMapping[to];
      var multi = formulas[unitFro.toString()][unitTo];


      var result = value * multi;


      resultText = '${userInput.toString()} $_startMeasures  --->  ${result
          .toString()} $_convertMeasures';
      setState(() {
        resultText = resultText;
      });
      successToast();
    }
    else
      cancelToast();

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
                Text('Speed Converter', style: TextStyle(
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
                      hintText: 'Enter the Speed',
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

