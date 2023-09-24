import 'package:flutter/material.dart';

class FinalReportPage extends StatefulWidget {
  @override
  _FinalReportPageState createState() => _FinalReportPageState();
}

class _FinalReportPageState extends State<FinalReportPage> {
  // Initialize variables for the values
  int cycleDuration = 0;
  DateTime nextPredictedDate = DateTime.now();
  String proneToPCOS = '';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final predictedG3 = args['predictedG3'] ?? 'default_value1';
    final pred = args['PCOS'] ?? 'default_value2';
    final dur = args['dura'] ?? 'default_value3';


    return Scaffold(
      appBar: AppBar(
        title: Text('Final Report'),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: <Widget>[
          ListTile(
            title: const Text('Cycle Duration:',
            style: TextStyle(fontSize: 20.0),),
            trailing: Text(dur.toString(),
              style: TextStyle(fontSize: 20.0),), // Display the value here
          ),
          SizedBox(height: 20,),
          ListTile(
            title: Text('Next Predicted Date:',
              style: TextStyle(fontSize: 20.0),),
            trailing: Text(predictedG3.toString(),
              style: TextStyle(fontSize: 20.0),), // Display the value here
          ),
          SizedBox(height: 20,),
          ListTile(
            title: Text('Prone to PCOS (Y/N?):',
              style: TextStyle(fontSize: 20.0),),
            trailing: (Text(pred,style: TextStyle(fontSize: 20.0),)) // Display the value here
          ),
        ],
      ),
    );
  }
}
