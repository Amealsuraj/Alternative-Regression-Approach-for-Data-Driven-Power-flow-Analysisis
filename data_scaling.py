import numpy as np
import pandas as pd

P = pd.read_csv('test_data/P.csv', header = None)
Q = pd.read_csv('test_data/Q.csv', header = None)
V = pd.read_csv('test_data/V.csv', header = None)
Va = pd.read_csv('test_data/Va.csv', header = None)
I= pd.read_csv('test_data/I.csv', header = None)
Ia = pd.read_csv('test_data/Ia.csv', header = None)

 
#Scaling 
from sklearn.preprocessing import MinMaxScaler
scaler=MinMaxScaler()

P=scaler.fit_transform(P)
P= pd.DataFrame(P)
Q=scaler.fit_transform(Q)
Q= pd.DataFrame(Q)
V=scaler.fit_transform(V)
V= pd.DataFrame(V)
Va=scaler.fit_transform(Va)
Va= pd.DataFrame(Va)
I=scaler.fit_transform(I)
I= pd.DataFrame(I)
Ia=scaler.fit_transform(Ia)
Ia= pd.DataFrame(Ia)
#Saving Scaled Data
P.to_csv('test_data/Scaled/P.csv', header = None,index=False)
Q.to_csv('test_data/Scaled/Q.csv', header = None,index=False)
V.to_csv('test_data/Scaled/V.csv', header = None,index =False)
Va.to_csv('test_data/Scaled/Va.csv', header = None,index=False)
I.to_csv('test_data/Scaled/I.csv', header = None,index=False)
Ia.to_csv('test_data/Scaled/Ia.csv', header = None,index=False)