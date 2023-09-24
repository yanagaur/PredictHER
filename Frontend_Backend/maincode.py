from flask import Flask, request, jsonify
from datetime import datetime,timedelta
import pickle

import json
from sklearn import linear_model
from sklearn.model_selection import train_test_split

from pendulum import DateTime
from pendulum import duration

from random import randint
from sklearn.model_selection import train_test_split
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
from darts import TimeSeries
from darts.models import AutoARIMA
from sklearn.metrics import mean_squared_error, mean_absolute_error, r2_score
import warnings
from model_001.time_series import TimeModel as TimeSeries_001
import pandas as pd
from io import StringIO



app = Flask(__name__)

@app.route('/predict2', methods=['POST'])
def predict2():
    # Get input data from the request
    input_data = request.get_json(force=True)
    df = pd.json_normalize(input_data)
    df.to_csv('output.csv', index=False)
    df = pd.read_csv('output.csv')
    data_list = []
    for index, row in df.iterrows():
        data_list.append(df['startDate'][index][0:10])
        data_list.append(df['endDate'][index][0:10])

    # Separate start and end dates
    start_dates = [datetime.strptime(data_list[i], '%Y-%m-%d') for i in range(0, len(data_list), 2)]
    end_dates = [datetime.strptime(data_list[i], '%Y-%m-%d') for i in range(1, len(data_list), 2)]

    # Calculate average difference between end of one cycle and start of next
    cycle_diffs = [(start_dates[i+1] - end_dates[i]).days for i in range(len(start_dates)-1)]
    avg_cycle_diff = sum(cycle_diffs) / len(cycle_diffs)

    # Calculate average length of a cycle (difference between start and end dates)
    cycle_lengths = [(end_date - start_date).days for start_date, end_date in zip(start_dates, end_dates)]
    avg_cycle_length = sum(cycle_lengths) / len(cycle_lengths)

    # Predict next start date by adding average cycle difference to last end date
    next_start_date = end_dates[-1] + timedelta(days=avg_cycle_diff)

    # Predict next end date by adding average cycle length to next start date
    next_end_date = next_start_date + timedelta(days=avg_cycle_length)
        

    
    

    

    response_data = {"predicted_G3": next_start_date.strftime('%d/%m/%Y'),"next_date":str(avg_cycle_diff)}
    
    return jsonify(response_data)


@app.route('/predict', methods=['POST'])
def predict():
    # Get input data from the request
    input_data = request.get_json(force=True)
    df = pd.json_normalize(input_data)
    df.to_csv('output.csv', index=False)
    new_csv = pd.DataFrame(columns=['M', 'Day', 'Year', 'Duration'])
    for index, row in df.iterrows():
        new_csv.loc[2*index] = [int(df['startDate'][index][5:7]),int(df['startDate'][index][8:10]),int(df['startDate'][index][0:4]),"Starts"]
        new_csv.loc[2*index+1] = [int(df['endDate'][index][5:7]),int(df['endDate'][index][8:10]),int(df['endDate'][index][0:4]),"Ends"]

    new_csv.to_csv('send_to_time_model.csv', index=False)
    

    pred = TimeSeries_001.time_model()
    df = pd.read_csv('send_to_time_model.csv')
    date_string = str(df.iloc[-2]['Day'])+"-"+str(df.iloc[-2]['M'])+"-"+str(df.iloc[-2]['Year'])
    date_format = "%d-%m-%Y"
    date_object = datetime.strptime(date_string, date_format)

    date_object = date_object + timedelta(days=pred)
    
    
    

    response_data = {"predicted_G3": str(date_object.strftime("%d-%m-%Y")),"next_date":str(pred)}
    
    return jsonify(response_data)

@app.route('/noreport', methods=['POST'])
def noreport():
    # Get input data from the request
    input_data = request.get_json(force=True)
    df = pd.json_normalize(input_data)
    
    with open('90.sav', 'rb') as file:
        report_model = pickle.load(file)
    
    df.to_csv('noreport_receive.csv', index=False)
    if df.loc[0, 'Cycle(R/I)'] == 'Regular':
        df.loc[0, 'Cycle(R/I)'] = 2
    else:
        df.loc[0, 'Cycle(R/I)'] = 4

    df = df.replace({False: 0, True: 1})

    with open('90.sav', 'rb') as file:
        report_model = pickle.load(file)

    ans = int(report_model.predict([df.iloc[0].tolist()])[0])
    send = ""
    if (ans == 0):
        send = "No"
    else:
        send = "Yes"
    
    

    response_data = {"predicted_G3": send}
    
    return jsonify(response_data)

@app.route('/yesreport', methods=['POST'])
def yesreport():
    # Get input data from the request
    input_data = request.get_json(force=True)
    df = pd.json_normalize(input_data)
    
    
    
    df.to_csv('report_receive.csv', index=False)
    
    with open('93.4per.sav', 'rb') as file:
        report_model = pickle.load(file)

    df = pd.read_csv('report_receive.csv')
    if df.loc[0, 'Cycle(R/I)'] == 'Regular':
        df.loc[0, 'Cycle(R/I)'] = 2
    else:
        df.loc[0, 'Cycle(R/I)'] = 4
    df = df.replace({False: 0, True: 1})

    if df.loc[0, 'Blood Group'].capitalize() == 'A+':
        df.loc[0, 'Blood Group'] = 11
    elif df.loc[0, 'Blood Group'].capitalize() == 'A-':
        df.loc[0, 'Blood Group'] = 12
    elif df.loc[0, 'Blood Group'].capitalize() == 'B+':
        df.loc[0, 'Blood Group'] = 13
    elif df.loc[0, 'Blood Group'].capitalize() == 'B-':
        df.loc[0, 'Blood Group'] = 14
    elif df.loc[0, 'Blood Group'].capitalize() == 'O+':
        df.loc[0, 'Blood Group'] = 15
    elif df.loc[0, 'Blood Group'].capitalize() == 'O-':
        df.loc[0, 'Blood Group'] = 16
    elif df.loc[0, 'Blood Group'].capitalize() == 'AB-':
        df.loc[0, 'Blood Group'] = 17
    else:
        df.loc[0, 'Blood Group'] = 18
        
    df.fillna(0, inplace=True)
        
    df.iloc[0].to_list()

    
    

    send = ""
    if (int(report_model.predict([df.iloc[0].to_list()])[0]) == 0):
        send = "No"
    else:
        send = "Yes"
    

    response_data = {"predicted_G3": int(report_model.predict([df.iloc[0].to_list()])[0])}
    
    return jsonify(response_data)


if __name__ == '__main__':
    app.run(debug=True)
