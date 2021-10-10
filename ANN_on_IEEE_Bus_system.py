#importing libraries
import pandas as pd
import numpy as np
import sklearn
import keras
import matplotlib.pyplot as plt
import tensorflow as tf


'''Do this just once - No need to do any more
!pip install -U -q PyDrive
 from pydrive.auth import GoogleAuth
from pydrive.drive import GoogleDrive
from google.colab import auth
from oauth2client.client import GoogleCredentials
Authenticate and create the PyDrive client.


auth.authenticate_user()
gauth = GoogleAuth()
gauth.credentials = GoogleCredentials.get_application_default()
drive = GoogleDrive(gauth)

id = "1EcWRAgZcqNwH9g9Ko-TkZvAZQSaTeZOu" # 30P
downloaded = drive.CreateFile({'id':id}) 
downloaded.GetContentFile('30P.csv')  
P = pd.read_csv('30P.csv', header=None)

id = "1pfx3L4ivHItHUlgvQKlmZZPVWS14rt81" # 30Q
downloaded = drive.CreateFile({'id':id}) 
downloaded.GetContentFile('30Q.csv')  
Q = pd.read_csv('30Q.csv', header=None)

id = "1Dq9lxJ5AI-IzX2lSmeENdV7iUvWam4Ev" # 30V
downloaded = drive.CreateFile({'id':id}) 
downloaded.GetContentFile('30V.csv')  
V = pd.read_csv('30V.csv', header=None)

id = "1P1h6FFRnFN0YyXP9S-4nJt5uYVV_KaIf" # 30Va
downloaded = drive.CreateFile({'id':id}) 
downloaded.GetContentFile('30Va.csv')  '''

#
P = pd.read_csv('data/30P.csv', header = None)
Q = pd.read_csv('data/30Q.csv', header = None)
V = pd.read_csv('data/30V.csv', header = None)
Va = pd.read_csv('data/30Va.csv', header = None)

print(P.shape)
print(Q.shape)
print(V.shape)
print(Va.shape)

num_train = P.shape[0]
num_bus = P.shape[1]


pi = 3.141592
Y = P.join(Q, lsuffix='_P', rsuffix='_Q')
X = Va.join(V, lsuffix='_V', rsuffix='_Va')
#Va = Va*pi/180

#Train_test splitting
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=0.2, random_state=42)

from keras.models import Sequential # Used to build model
from keras.layers import Dense # Type of layer
from keras.optimizers import Adam # Optimization technique
from keras.layers import Dropout # For tuning the neural network
from keras import regularizers # For regularization

#initializing neural network
model1 = Sequential()
model1.add(Dense(num_bus, input_dim=num_bus*2, kernel_initializer='normal', kernel_regularizer=regularizers.l2(0.001), activation='relu'))
model1.add(Dense(num_bus*2, kernel_initializer='normal', kernel_regularizer=regularizers.l2(0.001), activation='relu'))
# model1.add(Dense(2, activation='softmax')) #in the output we have two neurons as this is the categorical model
# compile model
adam = Adam(lr=0.001)
mape = tf.keras.losses.MeanAbsolutePercentageError()
m = tf.keras.metrics.MeanAbsolutePercentageError(
    name="mean_absolute_percentage_error", dtype=None
)
model1.compile(loss=mape, optimizer='adam', metrics=[m])

model1.summary()

# fit the model1(categorical one) to the training data
history1=model1.fit(X_train, y_train, validation_data=(X_test, y_test),epochs=500, batch_size=1) 



'''#To plot accuracy vs val_accuracy
plt.plot(history1.history['acc'])
plt.plot(history1.history['val_acc'])
plt.title('Model Accuracy')'''

from keras.callbacks import ModelCheckpoint
from keras.models import Sequential
from keras.layers import Dense, Activation, Flatten
from sklearn.model_selection import train_test_split
from sklearn.ensemble import RandomForestRegressor
from sklearn.metrics import mean_absolute_error 
from matplotlib import pyplot as plt
import seaborn as sb
import matplotlib.pyplot as plt
import pandas as pd
import numpy as np
import warnings 
warnings.filterwarnings('ignore')
warnings.filterwarnings('ignore', category=DeprecationWarning)
from xgboost import XGBRegressor

print(X_train.shape)
print(y_train.shape)
print(X_test.shape)
print(y_test.shape)


'''NN_model = Sequential()

# The Input Layer :
NN_model.add(Dense(num_bus*2, kernel_initializer='normal',input_dim = X_train.shape[1], activation='relu'))

# The Hidden Layers :
NN_model.add(Dense(num_bus, kernel_initializer='normal',activation='relu'))
# NN_model.add(Dense(256, kernel_initializer='normal',activation='relu'))
# NN_model.add(Dense(256, kernel_initializer='normal',activation='relu'))

# The Output Layer :
NN_model.add(Dense(num_bus*2, kernel_initializer='normal',activation='linear'))

# Compile the network :
NN_model.compile(loss='mean_absolute_percentage_error', optimizer='adam', metrics=['mean_absolute_percentage_error'])
NN_model.summary()

checkpoint_name = 'Weights-{epoch:03d}--{val_loss:.5f}.hdf5' 
checkpoint = ModelCheckpoint(checkpoint_name, monitor='val_loss', verbose = 1, save_best_only = True, mode ='auto')
callbacks_list = [checkpoint]

NN_model.fit(X_train, y_train, validation_data=(X_test, y_test), epochs=500, batch_size=32, callbacks=callbacks_list)'''

