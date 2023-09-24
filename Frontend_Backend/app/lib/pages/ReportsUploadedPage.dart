import 'package:flutter/material.dart';
import 'FinalReportPage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class ReportsUploadedPage extends StatefulWidget {
  @override
  _ReportsUploadedPageState createState() => _ReportsUploadedPageState();
}

class _ReportsUploadedPageState extends State<ReportsUploadedPage> {

  String? modelPred;
  // Define variables to store user inputs
  String age = '2';
  double weight = 0.0;
  double height = 0.0;
  double bmi = 0.0;
  String bloodGroup = 'A+';
  int pulseRate = 0;
  int respirationRate = 0;
  double hemoglobin = 0.0;
  String cycleType = 'Regular'; // Default cycle type is Regular
  int cycleLength = 0;
  int marriageStatus = 0;
  bool isPregnant = false;
  int numberOfAbortions = 0;
  double betaHCG1 = 0.0;
  double betaHCG2 = 0.0;
  double fsh = 0.0;
  double lh = 0.0;
  double fshToLhRatio = 0.0;
  double hipSize = 0.0;
  double waistSize = 0.0;
  double waistToHipRatio = 0.0;
  double tsh = 0.0;
  double amh = 0.0;
  double prl = 0.0;
  double vitD3 = 0.0;
  double prg = 0.0;
  double rbs = 0.0;
  bool weightGain = false;
  bool hairGrowth = false;
  bool skinDarkening = false;
  bool hairLoss = false;
  bool pimples = false;
  bool fastFood = false;
  bool regularExercise = false;
  int systolicBP = 0;
  int diastolicBP = 0;
  int follicleNoLeft = 0;
  int follicleNoRight = 0;
  double avgFSizeLeft = 0.0;
  double avgFSizeRight = 0.0;
  double endometriumThickness = 0.0;
  bool bmiA = false;
  bool bmiB = false;
  bool bmiC = false;
  bool? hypoS = false;
  bool? normalS = false;
  bool? preHyperS = false;
  bool? hyperS = false;
  bool abn1 = false;
  bool abn2 = false;
  bool nrml = false;

  Future<void> sendData() async {
    var url = Uri.parse('http://10.0.2.2:5000/yesreport');
    Map<String, dynamic> data = {
      'Age (yrs)': age,
      'Weight (Kg)':weight,
      'Height(Cm)':height,
      'BMI':bmi,
      'Blood Group':bloodGroup,
      'Pulse rate(bpm)':pulseRate,
      'RR (breaths/min)':respirationRate,
      'Hb(g/dl)':hemoglobin,
      'Cycle(R/I)':cycleType,
      'Cycle length(days)':cycleLength,
      'Marraige Status (Yrs)':marriageStatus,
      'Pregnant(Y/N)':isPregnant,
      'No. of abortions':numberOfAbortions,
      'I   beta-HCG(mIU/mL)': betaHCG1,
      'II    beta-HCG(mIU/mL)':betaHCG2,
      'FSH(mIU/mL)':fsh,
      'LH(mIU/mL)':lh,
      'FSH/LH':fshToLhRatio,
      'Hip(inch)':hipSize,
      'Waist(inch) ':waistSize,
      'Waist:Hip Ratio':waistToHipRatio,
      'TSH (mIU/L)':tsh,
      'AMH(ng/mL) ':amh,
      'PRL(ng/mL) ':prl,
      'Vit D3 (ng/mL)':vitD3,
      'PRG(ng/mL)':prg,
      'RBS(mg/dl)':rbs,
      'Weight gain(Y/N)':weightGain,
      'hair growth(Y/N)':hairGrowth,
      'Skin darkening (Y/N)':skinDarkening,
      'Hair loss(Y/N)': hairLoss,
      'Pimples(Y/N)':pimples,
      'Fast food (Y/N)':fastFood,
      'Reg.Exercise(Y/N)':regularExercise,
      'BP _Systolic (mmHg)':systolicBP,
      'BP _Diastolic (mmHg)':diastolicBP,
      'Follicle No. (L)':follicleNoLeft,
      'Follicle No. (R)':follicleNoRight,
      'Avg. F size (L) (mm)':avgFSizeLeft,
      'Avg. F size (R) (mm)':avgFSizeRight,
      'Endometrium (mm)':endometriumThickness,
      'BMI_a':bmiA,
      'BMI_b':bmiB,
      'BMI_c':bmiC,
      'hypo_s':hypoS,
      'normal_s':normalS,
      'pre_hyper_s':preHyperS,
      'hyper_s':hyperS,
      'abn1':abn1,
      'abn2':abn2,
      'nrml':nrml
    };
    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: jsonEncode(data));


    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      modelPred = result['predicted_G3'];

      // If the server returns a 200 OK response, parse the JSON.
      print('Response data: ${result['predicted_G3']}');


    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to send data');
    }

  }

  // Method to calculate FSH/LH ratio
  void calculateFSHLHRatio() {
    if (lh != 0.0) {
      setState(() {
        fshToLhRatio = fsh / lh;
      });
    }
  }

// Method to calculate waist-to-hip ratio
  void calculateWaistToHipRatio() {
    if (waistSize != 0.0 && hipSize != 0.0) {
      setState(() {
        waistToHipRatio = waistSize / hipSize;
      });
    }
  }

  // method to return status using Lh
  String getLhStatus(double value) {
    if (value < 2) {
      return 'abn1';
    } else if (value > 10) {
      return 'abn2';
    } else {
      return 'nrml';
    }
  }



  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final predictedG3 = args['predictedG3'];
    final dur = args['dura'];


    return Scaffold(
        appBar: AppBar(
          title: Text('Reports Uploaded'),
        ),
        body: SingleChildScrollView(
        child: Padding(
        padding: EdgeInsets.all(16.0),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
    // Define your input fields here
    Row(
    children: <Widget>[
    Text('Age (yrs):'),
    SizedBox(width: 10.0),
    Expanded(
    child: TextFormField(
    keyboardType: TextInputType.number,
    onChanged: (value) {
    setState(() {
    age = value;
    });
    },
    ),
    ),
    ],
    ),
    SizedBox(height: 20.0),
    Row(
    children: <Widget>[
    Text('Weight (Kg):'),
    SizedBox(width: 10.0),
    Expanded(
    child: TextFormField(
    keyboardType: TextInputType.numberWithOptions(decimal: true),
    onChanged: (value) {
    setState(() {
    weight = double.tryParse(value) ?? 0.0;
    });
    },
    ),
    ),
    ],
    ),
    // Add more input fields for other data
    // ...
    Row(
      children: <Widget>[
        Text('Height (Cm):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                height = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

      // BMI Input Field and Radio Buttons
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
    Row(
      children: <Widget>[
        Text('Blood Group:'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            onChanged: (value) {
              setState(() {
                bloodGroup = value;
              });
            },
          ),
        ),
      ],
    ),
    Row(
      children: <Widget>[
        Text('Pulse rate (bpm):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                pulseRate = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    ),
      // RR (breaths/min) Input Field
    Row(
      children: <Widget>[
        Text('RR (breaths/min):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                respirationRate = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    ),

// Hb (g/dl) Input Field
    Row(
      children: <Widget>[
        Text('Hb (g/dl):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                hemoglobin = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),
    // Cycle(R/I) Input Field and Radio Buttons
    Row(
      children: <Widget>[
        Text('Cycle(R/I):'),
        SizedBox(width: 10.0),
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
      // Cycle Length Input Field
    Row(
      children: <Widget>[
        Text('Cycle length(days):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                cycleLength = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    ),
      // Marriage Status Input Field
    Row(
      children: <Widget>[
        Text('Marriage Status (Yrs):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                marriageStatus = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    ),
// Space between Cycle length and Pregnant(Y/N) text
      SizedBox(height: 20.0),

// Pregnant (Y/N) Toggle Button with custom size and spacing
    Row(
      children: <Widget>[
        Text('Pregnant(Y/N):'),
        SizedBox(width: 10.0),
        SizedBox(width: 20.0), // Add space here
        Container(
          width: 120.0, // Adjust the width as needed
          child: ToggleButtons(
            children: <Widget>[
              Text('Yes'),
              Text('No'),
            ],
            isSelected: [isPregnant, !isPregnant],
            onPressed: (index) {
              setState(() {
                isPregnant = index == 0;
              });
            },
          ),
        ),
      ],
    ),

    // abortions field-
    Row(
      children: <Widget>[
        Text('No. of Abortions:'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                numberOfAbortions = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    ),

    // beta hcg | field-
    Row(
      children: <Widget>[
        Text('I beta-HCG (mIU/mL):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                betaHCG1 = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

    //// beta hcg || field-
    Row(
      children: <Widget>[
        Text('II beta-HCG (mIU/mL):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                betaHCG2 = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

    // FSH field
    Row(
      children: <Widget>[
        Text('FSH (mIU/mL):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                fsh = double.tryParse(value) ?? 0.0;
                // Update the FSH/LH ratio when FSH value changes
                calculateFSHLHRatio();
                // Update the waist-to-hip ratio when FSH or waist size changes
                calculateWaistToHipRatio();
              });
            },
          ),
        ),
      ],
    ),

// LH field
    Row(
      children: <Widget>[
        Text('LH (mIU/mL):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                lh = double.tryParse(value) ?? 0.0;
                // Update the FSH/LH ratio when LH value changes
                calculateFSHLHRatio();
                // Update the waist-to-hip ratio when LH or waist size changes
                calculateWaistToHipRatio();
              });
            },
          ),
        ),
      ],
    ),

    // space between lh and lhstatus display
    SizedBox(height: 20.0),

    // display 'abn1', 'abn2', 'nrml' according to lh
    Text('LH Status: ${getLhStatus(lh)}'),

    // space between lhstatus display and fsh to lh ratio display
    SizedBox(height: 20.0),

// FSH/LH Ratio display (uneditable by user)
    Row(
      children: <Widget>[
        Text('FSH/LH Ratio:'),
        SizedBox(width: 10.0),
        Text(fshToLhRatio.toStringAsFixed(2)), // Display the calculated ratio
      ],
    ),

// Hip (inch) field
    Row(
      children: <Widget>[
        Text('Hip (inch):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                hipSize = double.tryParse(value) ?? 0.0;
                // Update the waist-to-hip ratio when hip size changes
                calculateWaistToHipRatio();
              });
            },
          ),
        ),
      ],
    ),

// Waist (inch) field
    Row(
      children: <Widget>[
        Text('Waist (inch):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                waistSize = double.tryParse(value) ?? 0.0;
                // Update the waist-to-hip ratio when waist size changes
                calculateWaistToHipRatio();
              });
            },
          ),
        ),
      ],
    ),

    // space between waist and waist to hip ratio display
    SizedBox(height: 20.0),

// Waist:Hip Ratio display (uneditable by user)
    Row(
      children: <Widget>[
        Text('Waist:Hip Ratio:'),
        SizedBox(width: 10.0),
        Text(waistToHipRatio.toStringAsFixed(2)), // Display the calculated ratio
      ],
    ),

    // TSH Input Field
    Row(
      children: <Widget>[
        Text('TSH (mIU/L):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                tsh = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

// AMH Input Field
    Row(
      children: <Widget>[
        Text('AMH (ng/mL):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                amh = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

// PRL Input Field
    Row(
      children: <Widget>[
        Text('PRL (ng/mL):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                prl = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

// Vit D3 Input Field
    Row(
      children: <Widget>[
        Text('Vit D3 (ng/mL):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                vitD3 = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

// PRG Input Field
    Row(
      children: <Widget>[
        Text('PRG (ng/mL):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                prg = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

// RBS Input Field
    Row(
      children: <Widget>[
        Text('RBS (mg/dl):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                rbs = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

    // space between rbs and weight gain
    SizedBox(height: 20.0),
// Weight gain (Y/N) Toggle Button
    Row(
      children: <Widget>[
        Text('Weight gain(Y/N):'),
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

    // space between weight gain and hair growth
    SizedBox(height: 20.0),
// Hair growth (Y/N) Toggle Button
    Row(
      children: <Widget>[
        Text('Hair growth(Y/N):'),
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

    // space between hair growth and skin darkeneing
    SizedBox(height: 20.0),
// Skin darkening (Y/N) Toggle Button
    Row(
      children: <Widget>[
        Text('Skin darkening (Y/N):'),
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

    // space between skin darkening and hair loss
    SizedBox(height: 20.0),
// Hair loss (Y/N) Toggle Button
    Row(
      children: <Widget>[
        Text('Hair loss(Y/N):'),
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

    // space between hair loss and pimples
    SizedBox(height: 20.0),
// Pimples (Y/N) Toggle Button
    Row(
      children: <Widget>[
        Text('Pimples(Y/N):'),
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

    // space between pimples and fast food
    SizedBox(height: 20.0),
// Fast food (Y/N) Toggle Button
    Row(
      children: <Widget>[
        Text('Fast food (Y/N):'),
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
                fastFood = index == 0;
              });
            },
          ),
        ),
      ],
    ),

    // space between fast food and regular exercise
    SizedBox(height: 20.0),
// Regular Exercise (Y/N) Toggle Button
    Row(
      children: <Widget>[
        Text('Reg.Exercise(Y/N):'),
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

// BP Systolic (mmHg) Input Field and Radio Buttons
    Row(
      children: <Widget>[
        Text('BP Systolic (mmHg):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                systolicBP = int.tryParse(value) ?? 0;
                // Update the BP radio buttons based on the entered value

              });
            },
          ),
        ),
      ],
    ),

// BP Diastolic (mmHg) Input Field
    Row(
      children: <Widget>[
        Text('BP Diastolic (mmHg):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                diastolicBP = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    ),

      Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Radio(
                value: true,
                groupValue: hypoS,
                onChanged: (value) {
                  setState(() {
                    hypoS = value != null ? value : false;
                    normalS = value != null ? !value : false;
                    preHyperS = value != null ? !value : false;
                    hyperS = value != null ? !value : false;
                  });
                },
              ),
              Text('hypo_s'),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: true,
                groupValue: normalS,
                onChanged: (value) {
                  setState(() {
                    hypoS = value != null ? !value : false;
                    normalS = value != null ? value : false;
                    preHyperS = value != null ? !value : false;
                    hyperS = value != null ? !value : false;
                  });
                },
              ),
              Text('normal_s'),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: true,
                groupValue: preHyperS,
                onChanged: (value) {
                  setState(() {
                    hypoS = value != null ? !value : false;
                    normalS = value != null ? !value : false;
                    preHyperS = value != null ? value : false;
                    hyperS = value != null ? !value : false;
                  });
                },
              ),
              Text('pre_hyper_s'),
            ],
          ),
          Row(
            children: <Widget>[
              Radio(
                value: true,
                groupValue: hyperS,
                onChanged: (value) {
                  setState(() {
                    hypoS = value != null ? !value : false;
                    normalS = value != null ? !value : false;
                    preHyperS = value != null ? !value : false;
                    hyperS = value != null ? value : false;
                  });
                },
              ),
              Text('hyper_s'),
            ],
          ),
        ],
      ),




// Follicle No. (Left) Input Field
    Row(
      children: <Widget>[
        Text('Follicle No. (L):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                follicleNoLeft = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    ),

// Follicle No. (Right) Input Field
    Row(
      children: <Widget>[
        Text('Follicle No. (R):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                follicleNoRight = int.tryParse(value) ?? 0;
              });
            },
          ),
        ),
      ],
    ),

// Avg. F size (Left) (mm) Input Field
    Row(
      children: <Widget>[
        Text('Avg. F size (L) (mm):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                avgFSizeLeft = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

// Avg. F size (Right) (mm) Input Field
    Row(
      children: <Widget>[
        Text('Avg. F size (R) (mm):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                avgFSizeRight = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),

// Endometrium (mm) Input Field
    Row(
      children: <Widget>[
        Text('Endometrium (mm):'),
        SizedBox(width: 10.0),
        Expanded(
          child: TextFormField(
            keyboardType: TextInputType.numberWithOptions(decimal: true),
            onChanged: (value) {
              setState(() {
                endometriumThickness = double.tryParse(value) ?? 0.0;
              });
            },
          ),
        ),
      ],
    ),





      // Add more input fields and radio buttons for other data
      // ...

      SizedBox(height: 20.0),
      ElevatedButton(
        onPressed: () async {
          await sendData();
          Navigator.of(context).pushNamed('/resultpage', arguments: {'predictedG3': predictedG3,'PCOS': modelPred,'dura':dur});
        },
          // Handle the data submission or any other action here
          // You can access the collected data using the state variable
        child: Text('Upload'),
      ),
    ],
    ),
        ),
        ),
    );
  }
}









