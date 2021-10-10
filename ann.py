#importing libraries
import pandas as pd
import numpy as np
import sklearn
import keras
import matplotlib.pyplot as plt
import tensorflow as tf
import os
from models.ann_models.ann_train import ann_train

import pickle

case_name ='case14'
data_size = 300;
address = 'train_data/' + case_name+'/'+str(data_size)+'/'
P = pd.read_csv(address +'P.csv', header = None)
Q = pd.read_csv(address+'Q.csv', header = None)
V = pd.read_csv( address+'V.csv', header = None)
Va = pd.read_csv(address+'Va.csv', header = None)
I= pd.read_csv(address+'I.csv', header = None)
Ia = pd.read_csv(address+'Ia.csv', header = None)
num_train = P.shape[0]
num_bus = P.shape[1]
#ref=69
#P.iloc[:,ref]=np.zeros((num_train,1))
 
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
P.to_csv(address+'Scaled/P.csv', header = None,index=False)
Q.to_csv(address+'Scaled/Q.csv', header = None,index=False)
V.to_csv(address+'Scaled/V.csv', header = None,index =False)
Va.to_csv(address+'Scaled/Va.csv', header = None,index=False)
I.to_csv(address+'Scaled/I.csv', header = None,index=False)
Ia.to_csv(address+'Scaled/Ia.csv', header = None,index=False)





ann_train(P,Q,V,Va,I,Ia,num_train,num_bus)
















