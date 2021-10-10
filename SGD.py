'''
Goal: Perform OLS
Input - P, Q, V, Va,I,Ia, num_train, num_bus
Output - Xv ,Xva;

'''
import numpy as np
import pandas as pd

def OLS(P, Q, V, Va, I,Ia, num_train, num_bus):
    import pandas as pd
    import numpy as np
    import sklearn
    
    
    X = pd.concat([P,Q,I,Ia],axis=1)
    

    from sklearn.linear_model import SGDRegressor
    from sklearn.multioutput import MultiOutputRegressor
    # X = [P Q I Ia]
    
    sgd  = SGDRegressor(max_iter=500,fit_intercept=True)
    multi = MultiOutputRegressor(sgd,n_jobs=-1)
    multi.fit(X,V)
    arr1 = np.array(sgd.coef_)
    arr2 = np.array(sgd.intercept_)
    Xv = np.column_stack((arr1,arr2))

    sgd2 = SGDRegressor(max_iter=500,fit_intercept =True)
    multi2 = MultiOutputRegressor(sgd,n_jobs=-1)
    multi2.fit(X,Va)
    arr3 = np.array(sgd2.coef_)
    arr4 = np.array(sgd2.intercept_)
    Xva = np.column_stack((arr3,arr4))
    return [ Xv, Xva]
import pandas as pd
import numpy as np
case_name ='case118'
data_size = 800;
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



[ Xv, Xva] = OLS(P, Q, V, Va,I,Ia, num_train, num_bus)

np.savetxt(address+'SGD'+"/Xv.csv", Xv, delimiter=",")
np.savetxt(address+'SGD'+"/Xva.csv", Xva, delimiter=",")

print(Xv.shape)
print(Xva.shape)