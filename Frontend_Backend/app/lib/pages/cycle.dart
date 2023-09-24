import 'dart:convert';

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:http/http.dart' as http;// Import the dart:async library

class cycle extends StatefulWidget {
  @override
  _cycleState createState() => _cycleState();
}

class CycleData {
  DateTime? startDate;
  DateTime? endDate;

  CycleData(this.startDate, this.endDate);
}

class _cycleState extends State<cycle> {
  List<CycleData> cycleDataList = [];
  String? pred;
  String? dur;
  String errorMessage = ''; // Message for missing dates

  bool isNextButtonEnabled() {
    // Check if all cycle data has been entered
    return cycleDataList.every((cycleData) =>
    cycleData.startDate != null && cycleData.endDate != null);
  }
  Future<void> sendCycleData() async {
    Uri url;
    if (cycleDataList.length >=9) {
      url = Uri.parse('http://10.0.2.2:5000/predict');
    }else{
      url = Uri.parse('http://10.0.2.2:5000/predict2');
    }


    List<Map<String, dynamic>> cycleDataListMap = [];

    for (CycleData cycleData in cycleDataList) {
      cycleDataListMap.add({
        'startDate': cycleData.startDate.toString(),
        'endDate': cycleData.endDate.toString(),
      });
    }
    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: jsonEncode(cycleDataListMap));


    if (response.statusCode == 200) {
      var result = jsonDecode(response.body);
      pred = result['predicted_G3'];
      dur = result["next_date"];
      // If the server returns a 200 OK response, parse the JSON.

    } else {
      // If the server returns an unsuccessful response code, throw an exception.
      throw Exception('Failed to send data');
    }
  }
  Future<void> _selectDate(BuildContext context, CycleData cycleData, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != DateTime.now()) {
      setState(() {
        if (isStartDate) {
          cycleData.startDate = picked;
        } else {
          cycleData.endDate = picked;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menstrual Cycle Data'),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(labelText: 'Number of Cycles'),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                int cycleCount = int.tryParse(value) ?? 0;
                cycleDataList = List.generate(
                  cycleCount,
                      (index) => CycleData(null, null),
                );
                setState(() {});
              },
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: cycleDataList.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  margin: EdgeInsets.all(8.0),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Cycle ${index + 1}'),
                        Row(
                          children: [
                            Text('Start Date: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 8.0), // Add a small space
                            GestureDetector(
                              onTap: () => _selectDate(context, cycleDataList[index], true),
                              child: Text(
                                cycleDataList[index].startDate != null
                                    ? '${cycleDataList[index].startDate!.toLocal()}'.split(' ')[0]
                                    : 'Select Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: cycleDataList[index].startDate != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Text('End Date: ', style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(width: 8.0), // Add a small space
                            GestureDetector(
                              onTap: () => _selectDate(context, cycleDataList[index], false),
                              child: Text(
                                cycleDataList[index].endDate != null
                                    ? '${cycleDataList[index].endDate!.toLocal()}'.split(' ')[0]
                                    : 'Select Date',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: cycleDataList[index].endDate != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onNextButtonPressed,
        child: Icon(Icons.arrow_forward),
      ),
      bottomSheet: errorMessage.isNotEmpty
          ? Container(
        color: Colors.red,
        padding: EdgeInsets.all(16.0),
        child: Text(
          errorMessage,
          style: TextStyle(color: Colors.white),
        ),
      )
          : null,
    );
  }

  void showErrorMessage(String message) {
    setState(() {
      errorMessage = message;
    });

    // Use a Timer to clear the error message after 2 seconds
    Timer(Duration(seconds: 1), () {
      setState(() {
        errorMessage = '';
      });
    });
  }

  void onNextButtonPressed() async {

    if (isNextButtonEnabled()) {
      await sendCycleData();
      // If all dates are entered, navigate to the next page
      Navigator.of(context).pushNamed('/hormonal_reports'
      ,arguments: {'predictedG3': pred,'dura':dur},
      );
    } else {
      // If any date is missing, show an error message temporarily
      showErrorMessage('Please enter dates for all cycles.');
    }
  }

}
