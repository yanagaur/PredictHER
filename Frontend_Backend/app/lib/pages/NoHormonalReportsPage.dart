import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:predicther_03/pages/FinalReportPage.dart';

class NoHormonalReportsPage extends StatefulWidget {
  @override
  _NoHormonalReportsPageState createState() => _NoHormonalReportsPageState();
}

class _NoHormonalReportsPageState extends State<NoHormonalReportsPage> {

  String? modelPred;

  String cycleType = 'Regular'; // Default cycle type is Regular
  int cycleLength = 28;
  double waistToHipRatio = 0.0;
  bool weightGain = false;
  bool hairGrowth = false;
  bool skinDarkening = false;
  bool hairLoss = false;
  bool pimples = false;
  bool fastFood = false;
  bool regularExercise = false;
  double bmi = 0.0;
  bool bmiA = false;
  bool bmiB = false;
  bool bmiC = false;


  Future<void> sendData() async {
    var url = Uri.parse('http://10.0.2.2:5000/noreport');
    Map<String, dynamic> data = {
      'Cycle(R/I)': cycleType,
      'Cycle length(days)':cycleLength,
      'Waist:Hip Ratio':waistToHipRatio,
      'Weight gain(Y/N)':weightGain,
      'hair growth(Y/N)':hairGrowth,
      'Skin darkening (Y/N)':skinDarkening,
      'Hair loss(Y/N)':hairLoss,
      'Pimples(Y/N)':pimples,
      'Fast food (Y/N)':fastFood,
      'Reg.Exercise(Y/N)':regularExercise,
      'BMI_a':bmiA,
      'BMI_b':bmiB,
      'BMI_c':bmiC
    };
    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: jsonEncode(data));


    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      modelPred = result['predicted_G3'];
      // If the server returns a 200 OK response, parse the JSON.
    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to send data');
    }

  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final predictedG3 = args['predictedG3'];
    final dur = args['dura'];
    return Scaffold(
      appBar: AppBar(
        title: Text("No Hormonal Report"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text('Cycle (R/I):'),
              Row(
                children: <Widget>[
                  Radio(
                    value: 'Regular',
                    groupValue: cycleType,
                    onChanged: (value) {
                      setState(() {
                        cycleType = value.toString();
                      });
                    },
                  ),
                  Text('Regular'),
                  Radio(
                    value: 'Irregular',
                    groupValue: cycleType,
                    onChanged: (value) {
                      setState(() {
                        cycleType = value.toString();
                      });
                    },
                  ),
                  Text('Irregular'),
                ],
              ),
              SizedBox(height: 20.0),
              Text('Cycle length (days):'),
              TextFormField(
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  setState(() {
                    cycleLength = int.tryParse(value) ?? 0;
                  });
                },
              ),
              SizedBox(height: 20.0),
              Text('Waist to Hip Ratio:'),
              TextFormField(
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onChanged: (value) {
                  setState(() {
                    waistToHipRatio = double.tryParse(value) ?? 0.0;
                  });
                },
              ),

              // distance between waistToHip ratio and weight gain
              SizedBox(height: 20.0),
              Row(
                children: <Widget>[
                  Text('Weight Gain (Y/N):'),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    child: ToggleButtons(
                      children: <Widget>[
                        Text('Yes'),
                        Text('No'),
                      ],
                      isSelected: [weightGain, !weightGain],
                      onPressed: (index) {
                        setState(() {
                          weightGain = index == 0;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // distance between weight gain and hair growth
              SizedBox(height: 20.0),

              Row(
                children: <Widget>[
                  Text('Hair Growth (Y/N):'),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    child: ToggleButtons(
                      children: <Widget>[
                        Text('Yes'),
                        Text('No'),
                      ],
                      isSelected: [hairGrowth, !hairGrowth],
                      onPressed: (index) {
                        setState(() {
                          hairGrowth = index == 0;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // distance between  hair growth and skin darkening
              SizedBox(height: 20.0),

              Row(
                children: <Widget>[
                  Text('Skin Darkening (Y/N):'),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    child: ToggleButtons(
                      children: <Widget>[
                        Text('Yes'),
                        Text('No'),
                      ],
                      isSelected: [skinDarkening, !skinDarkening],
                      onPressed: (index) {
                        setState(() {
                          skinDarkening = index == 0;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // distance between  skin darkening and hair loss
              SizedBox(height: 20.0),

              Row(
                children: <Widget>[
                  Text('Hair Loss (Y/N):'),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    child: ToggleButtons(
                      children: <Widget>[
                        Text('Yes'),
                        Text('No'),
                      ],
                      isSelected: [hairLoss, !hairLoss],
                      onPressed: (index) {
                        setState(() {
                          hairLoss = index == 0;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // distance between  hair loss and pimples
              SizedBox(height: 20.0),

              Row(
                children: <Widget>[
                  Text('Pimples (Y/N):'),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    child: ToggleButtons(
                      children: <Widget>[
                        Text('Yes'),
                        Text('No'),
                      ],
                      isSelected: [pimples, !pimples],
                      onPressed: (index) {
                        setState(() {
                          pimples = index == 0;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // distance between pimples and fast food.
              SizedBox(height: 20.0),

              Row(
                children: <Widget>[
                  Text('Fast Food (Y/N):'),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    child: ToggleButtons(
                      children: <Widget>[
                        Text('Yes'),
                        Text('No'),
                      ],
                      isSelected: [fastFood, !fastFood],
                      onPressed: (index) {
                        setState(() {
                          fastFood  = index == 0;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // distance between fast food and regular exercise
              SizedBox(height: 20.0),

              Row(
                children: <Widget>[
                  Text('Regular Exercise (Y/N):'),
                  SizedBox(width: 10.0),
                  Container(
                    width: 120.0,
                    child: ToggleButtons(
                      children: <Widget>[
                        Text('Yes'),
                        Text('No'),
                      ],
                      isSelected: [regularExercise, !regularExercise],
                      onPressed: (index) {
                        setState(() {
                          regularExercise = index == 0;
                        });
                      },
                    ),
                  ),
                ],
              ),

              // distance between regular exercise and bmi handler.
              SizedBox(height: 20.0),


              Row(
                children: <Widget>[
                  Text('BMI:'),
                  SizedBox(width: 10.0),
                  Expanded(
                    child: TextFormField(
                      keyboardType: TextInputType.numberWithOptions(decimal: true),
                      onChanged: (value) {
                        setState(() {
                          bmi = double.tryParse(value) ?? 0.0;
                          // Update the BMI radio buttons based on the entered value
                          if (bmi < 18) {
                            bmiA = true;
                            bmiB = false;
                            bmiC = false;
                          } else if (bmi >= 18 && bmi <= 26) {
                            bmiA = false;
                            bmiB = true;
                            bmiC = false;
                          } else {
                            bmiA = false;
                            bmiB = false;
                            bmiC = true;
                          }
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: <Widget>[

                  Text('BMI_a'),
                  Radio(
                    value: true,
                    groupValue: bmiA,
                    onChanged: (value) {},
                  ),
                  Text('BMI_b'),
                  Radio(
                    value: true,
                    groupValue: bmiB,
                    onChanged: (value) {},
                  ),
                  Text('BMI_c'),
                  Radio(
                    value: true,
                    groupValue: bmiC,
                    onChanged: (value) {},
                  ),
                ],
              ),
              SizedBox(height: 20.0),
              ElevatedButton(
                onPressed: () async {
                  await sendData();
                  Navigator.of(context).pushNamed('/resultpage', arguments: {'predictedG3': predictedG3,'PCOS': modelPred,'dura':dur});
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}