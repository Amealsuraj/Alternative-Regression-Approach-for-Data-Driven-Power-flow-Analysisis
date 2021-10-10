#importing libraries
import pandas as pd
import numpy as np
import sklearn

# Reading various data from bus systems in .csv format
P = pd.read_csv('data/30P.csv', header = None)
Q = pd.read_csv('data/30Q.csv', header = None)
V = pd.read_csv('data/30V.csv', header = None)
Va = pd.read_csv('data/30Va.csv', header = None)

# Confirming the shape of received Pandas dataframes
print("P.shape: ",P.shape)
print("Q.shape: ",Q.shape)
print("V.shape: ",V.shape)
print("Va.shape: ",Va.shape)

# Finding num_train and num_bus, used to train model
num_train = P.shape[0]
num_bus = P.shape[1]
'''
Creating data for training, X and Y

No need to convert degrees into radians (probably already in degrees)
Forward regression :
    Input - Y
    Output - X

Inverse regressoin :
    Input - X
    output - Y
'''
pi = 3.141592
Y = P.join(Q, lsuffix='_P', rsuffix='_Q')

# Separate regressions used
X = Va.join(V, lsuffix='_Va', rsuffix='_V')

# print(X.shape, Y.shape)

# Breaking X and Y into training and testing data. Not needed as 
# from sklearn.model_selection import train_test_split
# X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size=0.2, random_state=10)

# X_train
# y_train
# X_test
# y_test

# Ordinary Least Squares (OLS)
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import cross_val_score

# Inverse linear regression
ols = LinearRegression()
scores = cross_val_score(ols, X, P, cv=5, scoring="neg_mean_absolute_percentage_error")
print("P - OLS - MAPE: ", scores.mean())

ols = LinearRegression()
scores = cross_val_score(ols, X, Q, cv=5, scoring="neg_mean_absolute_percentage_error")
print("Q - OLS - MAPE: ", scores.mean())




# va_Xv = ols.coef_

# import matplotlib.pyplot as plt
# Xva_Xv.shape
# plt.figure(figsize=(20,10))
# plt.imshow(Xva_Xv, interpolation='none')
# plt.show()

# Forward linear regression
ols2 = LinearRegression()
scores = cross_val_score(ols2, Y, V, cv=5, scoring="neg_mean_absolute_error")
print("V - OLS - MAE: ", scores.mean())

ols2 = LinearRegression()
scores = cross_val_score(ols2, Y, Va, cv=5, scoring="neg_mean_absolute_error")
print("Va - OLS - MAE: ", scores.mean())


# ols2.fit(Y,X)
# Xp_Xq = ols2.coef_

# Xp_Xq.shape
# plt.figure(figsize=(20,10))
# plt.imshow(Xp_Xq, interpolation='none')
# plt.show()

# Partial Least Squares regression (PLS)

# Inverse regression
from sklearn.cross_decomposition import PLSRegression
pls = PLSRegression()

scores = cross_val_score(pls, X, P, cv=5, scoring="neg_mean_absolute_percentage_error")
print("P - PLS - MAPE: ", scores.mean())

scores = cross_val_score(pls, X, Q, cv=5, scoring="neg_mean_absolute_percentage_error")
print("Q - PLS - MAPE: ", scores.mean())


# pls.fit(X,Y)
# Xva_Xv = pls.coef_
# plt.figure(figsize=(20,10))
# plt.imshow(Xva_Xv, interpolation='none')
# plt.show()

# Forward Regression
pls2 = PLSRegression()
scores = cross_val_score(pls2, Y, V, cv=5, scoring="neg_mean_absolute_error")
print("V - PLS - MAE: ", scores.mean())

pls2 = PLSRegression()
scores = cross_val_score(pls2, Y, Va, cv=5, scoring="neg_mean_absolute_error")
print("Va - PLS - MAE: ", scores.mean())


# pls2.fit(X,Y)
# Xp_Xq = pls2.coef_
# plt.figure(figsize=(20,10))
# plt.imshow(Xp_Xq, interpolation='none')
# plt.show()


# Bayesian Linear regression (BLR)

# Inverse regression - Bayesian Ridge requires single output array


from sklearn.linear_model import ARDRegression
ard = ARDRegression()

scores = cross_val_score(ard, X, P, cv=5,scoring="neg_mean_absolute_percentage_error")
print("P - BLR - MAPE: ", scores.mean())

scores = cross_val_score(ard, X, Q, cv=5,scoring="neg_mean_absolute_percentage_error")
print("Q - BLR - MAPE: ", scores.mean())

# blr.fit(X,Y)
# Xva_Xv = blr.coef_
# plt.figure(figsize=(20,10))
# plt.imshow(Xva_Xv, interpolation='none')
# plt.show()

# Forward regression
ard2 = ARDRegression()

scores = cross_val_score(ard2, Y, V, cv=5, scoring="neg_mean_absolute_error")
print("V - BLR - MAE: ", scores.mean())

scores = cross_val_score(blr2, Y, Va, cv=5, scoring="neg_mean_absolute_error")
print("Va - BLR - MAE: ", scores.mean())

# blr2.fit(X,Y)
# Xp_Xq = blr2.coef_
# plt.figure(figsize=(20,10))
# plt.imshow(Xp_Xq, interpolation='none')
# plt.show()

'''
Implemented Linear regression, PLS and BLR
Next step:
1. To verify the implementation
2. Test for various Bus systems
3. Store results in excel sheets

'''