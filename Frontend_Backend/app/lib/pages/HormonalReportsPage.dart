import 'package:flutter/material.dart';
import 'NoHormonalReportsPage.dart'; // Import the NoHormonalReportsPage
import 'ReportsUploadedPage.dart'; // Import the ReportsUploadedPage

class HormonalReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map;
    final predictedG3 = args['predictedG3'];
    final dur = args['dura'];


    return Scaffold(
      appBar: AppBar(
        title: Text('Hormonal Reports'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Do you have your hormonal reports?',
              style: TextStyle(fontSize: 20.0),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the ReportsUploadedPage when the user presses "Yes"
                Navigator.of(context).pushNamed('/reports_uploaded'
                  ,arguments: {'predictedG3': predictedG3,'dura':dur},
                );
              },
              child: Text('Yes'),
            ),
            SizedBox(height: 10.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to the NoHormonalReportsPage when the user presses "No"
                Navigator.of(context).pushNamed('/no_hormonal_reports'
                  ,arguments: {'predictedG3': predictedG3,'dura':dur},
                );
              },
              child: Text('No'),

            ),
            SizedBox(height: 20.0),
            Text('Next Start date Prediction: $predictedG3',
              style: const TextStyle(fontSize: 17.0),),
          ],
        ),
      ),
    );
  }
}
